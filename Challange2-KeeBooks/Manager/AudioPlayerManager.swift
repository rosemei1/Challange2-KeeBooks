import Foundation
import AVFoundation
import MediaPlayer
import UIKit
import Combine

@MainActor
final class AudioPlayerManager:NSObject, ObservableObject {

    static let shared = AudioPlayerManager()

    // MARK: - Player

    private var player: AVPlayer?

    private var timeObserver: Any?

    private var previewTimer: Timer?

    private let previewDuration: Double = 10

    // MARK: - Published

    @Published var currentBook: Book?

    @Published var isPlaying = false

    @Published var currentTime: Double = 0

    @Published var duration: Double = 1

    // MARK: - Init

    private override init() {

        super.init()

        setupAudioSession()

        setupRemoteTransportControls()
    }

    deinit {

        if let observer = timeObserver {

            player?.removeTimeObserver(observer)
        }

        previewTimer?.invalidate()
    }

    // MARK: - Play Full Audiobook

    func play(book: Book) {

        cleanupPlayer()

        guard let url = Bundle.main.url(
            forResource: book.audio,
            withExtension: "mp3"
        ) else {

            print("Audio file not found")

            return
        }

        currentBook = book

        player = AVPlayer(url: url)

        setupTimeObserver()

        // Determine playback start time
        let startTime: Double

        if book.status == "completed" {
            startTime = 0
        } else {
            startTime = book.bookmark ?? 0
        }

        let seekTime = CMTime(
            seconds: startTime,
            preferredTimescale: 600
        )

        player?.seek(to: seekTime)

        player?.play()

        isPlaying = true

        setupNowPlaying(book: book)
    }

    // MARK: - Preview

    func playPreview(book: Book) {

        cleanupPlayer()

        guard let url = Bundle.main.url(
            forResource: book.audio,
            withExtension: "mp3"
        ) else {

            print("Audio file not found")

            return
        }

        currentBook = book

        player = AVPlayer(url: url)

        setupTimeObserver()

        player?.seek(to: .zero)

        player?.play()

        isPlaying = true

        setupNowPlaying(book: book)

        previewTimer = Timer.scheduledTimer(
            withTimeInterval: previewDuration,
            repeats: false
        ) { [weak self] _ in

            guard let self else { return }

            self.stop()
        }
    }

    // MARK: - Toggle

    func togglePlayPause() {

        guard let player else { return }

        if isPlaying {

            pause()

        } else {

            player.play()

            isPlaying = true
        }
    }

    // MARK: - Pause

    func pause() {

        player?.pause()

        isPlaying = false

        saveBookmark()
    }

    // MARK: - Stop

    func stop() {

        player?.pause()

        saveBookmark()

        isPlaying = false
    }

    // MARK: - Sleep Stop

    func stopBecauseUserFellAsleep() {

        player?.pause()

        saveBookmark()

        isPlaying = false

        print("Playback stopped because user is asleep")
    }

    // MARK: - Save Bookmark

    func saveBookmark() {

        guard let currentBook else { return }

        currentBook.bookmark = currentTime
    }

    // MARK: - Seek

    func seek(to value: Double) {

        let time = CMTime(
            seconds: value,
            preferredTimescale: 600
        )

        player?.seek(to: time)

        currentTime = value

        saveBookmark()
    }

    // MARK: - Forward / Backward

    func forward10Seconds() {

        guard let player else { return }

        let current = player.currentTime().seconds

        seek(to: current + 10)
    }

    func backward10Seconds() {

        guard let player else { return }

        let current = player.currentTime().seconds

        seek(to: max(current - 10, 0))
    }

    // MARK: - Observer

    private func setupTimeObserver() {

        guard let player else { return }

        if let observer = timeObserver {

            player.removeTimeObserver(observer)

            timeObserver = nil
        }

        let interval = CMTime(
            seconds: 1,
            preferredTimescale: 600
        )

        timeObserver = player.addPeriodicTimeObserver(
            forInterval: interval,
            queue: .main
        ) { [weak self] time in

            guard let self else { return }

            self.currentTime = time.seconds

            self.saveBookmark()

            if let duration =
                player.currentItem?.duration.seconds,
               duration.isFinite {

                self.duration = duration
            }
        }
    }

    // MARK: - Cleanup

    private func cleanupPlayer() {

        stopPreviewTimer()

        if let observer = timeObserver {

            player?.removeTimeObserver(observer)

            timeObserver = nil
        }

        player?.pause()

        currentTime = 0

        duration = 1
    }

    private func stopPreviewTimer() {

        previewTimer?.invalidate()

        previewTimer = nil
    }

    // MARK: - Audio Session

    private func setupAudioSession() {

        do {

            try AVAudioSession.sharedInstance()
                .setCategory(
                    .playback,
                    mode: .spokenAudio
                )

            try AVAudioSession.sharedInstance()
                .setActive(true)

            UIApplication.shared
                .beginReceivingRemoteControlEvents()

        } catch {

            print(error.localizedDescription)
        }
    }

    // MARK: - Now Playing

    private func setupNowPlaying(book: Book) {

        var nowPlaying: [String: Any] = [

            MPMediaItemPropertyTitle:
                book.title,

            MPMediaItemPropertyArtist:
                "\(book.author) • \(book.narrator)"
        ]

        if let image = UIImage(named: book.cover) {

            let artwork = MPMediaItemArtwork(
                boundsSize: image.size
            ) { _ in image }

            nowPlaying[
                MPMediaItemPropertyArtwork
            ] = artwork
        }

        MPNowPlayingInfoCenter
            .default()
            .nowPlayingInfo = nowPlaying
    }

    // MARK: - Remote Controls

    private func setupRemoteTransportControls() {

        let commandCenter =
            MPRemoteCommandCenter.shared()

        commandCenter.playCommand
            .addTarget { [weak self] _ in

                self?.player?.play()

                self?.isPlaying = true

                return .success
            }

        commandCenter.pauseCommand
            .addTarget { [weak self] _ in

                self?.pause()

                return .success
            }
    }

    // MARK: - Formatter

    func formatTime(_ seconds: Double) -> String {

        guard !seconds.isNaN else {

            return "00:00"
        }

        let minutes = Int(seconds) / 60

        let secs = Int(seconds) % 60

        return String(
            format: "%02d:%02d",
            minutes,
            secs
        )
    }
}

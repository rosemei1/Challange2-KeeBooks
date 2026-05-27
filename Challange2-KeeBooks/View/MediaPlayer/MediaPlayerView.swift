//
//  MediaPlayerView.swift
//  Challange2-KeeBooks
//
//  Created by Fuad Agus Salim on 20/05/26.
//

import SwiftUI

struct MediaPlayerView: View {

    var book: Book
    var isPreview: Bool = false

    @Environment(\.dismiss) private var dismiss

    @StateObject private var player =
        AudioPlayerManager.shared

    @State private var isDraggingSlider = false

    var body: some View {

        ZStack {

            VStack(spacing: 0) {

                GeometryReader { geo in

                    Image(book.cover)
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: geo.size.width,
                            height: geo.size.height,
                            alignment: Alignment(horizontal: .center, vertical: .top)
                        )
                        .clipped()
                        
                }
                .frame(height: 450)
//                .padding(.top, 4)

                VStack(alignment: .leading, spacing: 4) {

                    Text(book.title)
                        .font(.title3)
                        .bold()

                    Text(book.author)
                        .font(.footnote)
                        .fontWeight(.semibold)

                    Text(book.narrator)
                        .font(.footnote)
                        .foregroundStyle(.secondary)

                    // MARK: - Slider

                    Slider(

                        value: Binding(

                            get: {
                                player.currentTime
                            },

                            set: { value in

                                player.currentTime = value
                            }
                        ),

                        in: 0...player.duration,

                        onEditingChanged: { editing in

                            isDraggingSlider = editing

                            if !editing {

                                player.seek(
                                    to: player.currentTime
                                )
                            }
                        }
                    )
                    .tint(Color.primary9)
                    .padding(.top, 4)

                    // MARK: - Time Labels

                    HStack {

                        Text(
                            player.formatTime(
                                player.currentTime
                            )
                        )

                        Spacer()

                        Text(
                            "-\(player.formatTime(player.duration - player.currentTime))"
                        )
                    }
                    .font(.caption2)
                    .foregroundStyle(.secondary)

                    Divider()
                        .padding(.vertical, 10)

                    // MARK: - Controls

                    HStack {

                        Spacer()

                        Button {

                            player.backward10Seconds()

                        } label: {

                            Image(systemName: "gobackward.10")
                                .font(.system(size: 28))
                                .foregroundStyle(Color.primary9)
                        }

                        Spacer()

                        Button {

                            if player.currentBook?.id != book.id || player.isPreview != isPreview {

                                if isPreview {
                                    player.playPreview(book: book)
                                } else {
                                    player.play(book: book)
                                }

                            } else {

                                player.togglePlayPause()
                            }

                        } label: {

                            Image(
                                systemName:
                                    player.isPlaying
                                    ? "pause.circle.fill"
                                    : "play.circle.fill"
                            )
                            .font(.system(size: 54))
                            .foregroundStyle(Color.primary9)
                        }

                        Spacer()

                        Button {

                            player.forward10Seconds()

                        } label: {

                            Image(systemName: "goforward.10")
                                .font(.system(size: 28))
                                .foregroundStyle(Color.primary9)
                        }

                        Spacer()
                    }
                }
                .padding(20)
                .background(.ultraThinMaterial)
            }
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 28,
                    style: .continuous
                )
            )
            .padding(.horizontal, 16)

        }
        .onAppear {
            if player.currentBook?.id != book.id || player.isPreview != isPreview {
                if isPreview {
                    player.playPreview(book: book)
                } else {
                    player.play(book: book)
                }
            }
        }
        .navigationTitle(isPreview ? "Preview" : "Player")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button { dismiss() } label: {
                    Image(systemName: "chevron.left")
                }
            }
            ToolbarItem(placement: .principal) {
                Text(isPreview ? "Preview" : "Player")
                    .font(.title2)
                    .fontWeight(.bold)
            }
        }
    }
}

#Preview {
    MediaPlayerView(book: Data.shared.books.first!)
}

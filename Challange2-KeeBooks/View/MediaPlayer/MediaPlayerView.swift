//
//  MediaPlayerView.swift
//  Challange2-KeeBooks
//
//  Created by Fuad Agus Salim on 20/05/26.
//

import SwiftUI

struct MediaPlayerView: View {

    var book: Book
    
    @Environment(\.dismiss) private var dismiss

    @StateObject private var player =
        AudioPlayerManager.shared

    @State private var isDraggingSlider = false

    var body: some View {

        ZStack {

            BackgroundView()
                .ignoresSafeArea()

            VStack(spacing: 0) {

                GeometryReader { geo in

                    Image(book.cover)
                        .resizable()
                        .scaledToFill()
                        .frame(
                            width: geo.size.width,
                            height: geo.size.height
                        )
                        .clipped()
                }
                .frame(height: 430)

                VStack(alignment: .leading) {

                    Text(book.title)
                        .font(.title)
                        .bold()

                    Text(book.author)
                        .font(.subheadline)
                        .fontWeight(.semibold)

                    Text(book.narrator)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.top, 8)

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
                    .padding(.top, 12)

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
                    .font(.caption)
                    .foregroundStyle(.secondary)

                    Divider()
                        .padding(.vertical, 16)

                    // MARK: - Controls

                    HStack {

                        Spacer()

                        Button {

                            player.backward10Seconds()

                        } label: {

                            Image(systemName: "gobackward.10")
                                .font(.system(size: 40))
                                .foregroundStyle(Color.primary9)
                        }

                        Spacer()

                        Button {

                            if player.currentBook?.id != book.id {

                                player.play(book: book)

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
                            .font(.system(size: 70))
                            .foregroundStyle(Color.primary9)
                        }

                        Spacer()

                        Button {

                            player.forward10Seconds()

                        } label: {

                            Image(systemName: "goforward.10")
                                .font(.system(size: 40))
                                .foregroundStyle(Color.primary9)
                        }

                        Spacer()
                    }
                }
                .padding(20)
                .background(.white)
            }
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 28,
                    style: .continuous
                )
            )
            .padding(.horizontal, 16)
            .shadow(
                color: .black.opacity(0.25),
                radius: 20,
                x: 0,
                y: 8
            )
        }
        .navigationTitle("Player")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {

            ToolbarItem(
                placement: .navigationBarLeading
            ) {

                Button {

                    dismiss()

                } label: {

                    Image(systemName: "chevron.left")
                }
            }
        }
    }
}

#Preview {
    MediaPlayerView(book: Data.shared.books.first!)
}

//
//  MediaPlayerView.swift
//  Challange2-KeeBooks
//
//  Created by Fuad Agus Salim on 20/05/26.
//

import SwiftUI

struct MediaPlayerView: View {
    var book: Books

    @Environment(\.dismiss) private var dismiss

    @State private var isPlaying = false
    @State private var progress: Double = 0.7

    var body: some View {
        NavigationStack {
            GeometryReader { screenGeo in
            VStack(spacing: 0) {
                // ZStack at top: book cover fills this section
                ZStack {
                    Image(book.cover)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity)
                        .frame(height: screenGeo.size.height * 4 / 6, alignment: .top)
                        .clipped()
                }
                .frame(maxWidth: .infinity)
                .clipped()

                // Controller below
                VStack(alignment: .leading, spacing: 0) {
                    Text(book.title)
                        .font(.title).bold()
                    Text(book.author)
                        .font(.subheadline).fontWeight(.semibold)
                        .padding(.top, 2)

                    Text(book.narrator)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .padding(.top, 10)

                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            Capsule()
                                .fill(Color(red: 0.76, green: 0.87, blue: 0.76))
                                .frame(height: 6)
                            Capsule()
                                .fill(Color(red: 0.18, green: 0.40, blue: 0.18))
                                .frame(width: geo.size.width * progress, height: 6)
                        }
                    }
                    .frame(height: 6)
                    .padding(.top, 10)

                    HStack {
                        Text("13:51")
                        Spacer()
                        Text("-41:51")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)

                    Divider()
                        .padding(.vertical, 14)

                    HStack {
                        Spacer()
                        Button { } label: {
                            Image(systemName: "gobackward.10")
                                .font(.system(size: 40))
                        }
                        Spacer()
                        Button { isPlaying.toggle() } label: {
                            Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                                .font(.system(size: 48))
                        }
                        Spacer()
                        Button { } label: {
                            Image(systemName: "goforward.10")
                                .font(.system(size: 40))
                        }
                        Spacer()
                    }
                    .foregroundStyle(.primary)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 24)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray6))
            }
            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
            .shadow(color: .black.opacity(0.25), radius: 20, x: 0, y: 8)
            .padding(.horizontal, 24)

            .navigationTitle("Player")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
            }
        }
    }
}
}

#Preview {
    MediaPlayerView(book: Books(
        title: "The Hunger Game",
        cover: "dummyBookCover",
        audio: "sample.mp3",
        author: "Suzanne Collins",
        narrator: "The Assasins",
        synopsis: "",
        duration: 3351,
        status: "unread"
    ))
}

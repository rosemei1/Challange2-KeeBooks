//
//  DetailView.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 20/05/26.
//

import SwiftUI

struct DetailView: View {

    var book: Books

    @State private var showPlayer = false

    var body: some View {

        NavigationStack {

            ScrollView {

                VStack {

                    Image(book.cover)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 202, height: 308)
                        .background(.gray)
                        .padding(.top, 50)
                        .shadow(radius: 30)

                    VStack {

                        Text(book.title)
                            .font(.title2)
                            .bold()

                        Text(book.author)
                            .font(.caption)
                            .fontWeight(.light)
                            .foregroundStyle(.secondary)

                        Text(book.narrator)
                            .font(.caption)
                            .fontWeight(.light)
                            .foregroundStyle(.secondary)

                        Text(book.duration.description)
                            .font(.caption)
                            .fontWeight(.light)
                            .foregroundStyle(.secondary)
                    }

                    HStack {

                        ButtonFilled(
                            label: "Play",
                            icon: "play.fill",
                            width: 150
                        ) {

                            showPlayer = true
                        }

                        ButtonOutlined(
                            label: "Pick",
                            icon: "hand.tap.fill"
                        ) {

                            print("Test")
                        }
                    }

                    VStack(alignment: .leading) {

                        Text("Synopsis:")
                            .font(.headline)
                            .bold()
                            .padding(.top, 16)

                        Text(book.synopsis)
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 32)
                }
            }
            .background {

                Color.primary1

                BackgroundView()
            }
            .sheet(isPresented: $showPlayer) {

                MediaPlayerView(book: book)
            }
        }
    }
}

#Preview {
    DetailView(
        book: Books(
            title: "The Hunger Game",
            cover: "dune",
            audio: "sample.mp3",
            author: "Suzanne Collins",
            narrator: "The Assasins",
            synopsis: "",
            duration: 3351,
            status: "unread"
        )
    )
}

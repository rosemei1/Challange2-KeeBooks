//
//  OnGoingSubView.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

import SwiftUI

struct OnGoingSubView: View {
    private let dummyBook = Book(
        title: "The Book Title",
        cover: "dummyBookCover",
        audio: "sample.mp3",
        author: "Author Name",
        narrator: "Narrator",
        synopsis: "",
        duration: 3600,
        status: "unread"
    )
    var body: some View {
        let items = Array(1...6)
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
        VStack {
            
            HStack (){
                Chevron(title: "On Going")

            }
            
            ForEach(items, id: \.self){ item in
                NavigationLink(destination: MediaPlayerView(book: dummyBook)) {
                   HorizontalCard()
                }
                .buttonStyle(.plain)
            }
//            HorizontalCard()
//            HorizontalCard()
//            HorizontalCard()
        }
        .padding()
    }
}


#Preview {
    OnGoingSubView()
}


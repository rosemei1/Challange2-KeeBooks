//
//  OnGoingSubView.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

import SwiftUI

struct OnGoingSubView: View {
    var body: some View {
        VStack {
            HStack {
                Chevron(title: "On Going")
            }

            ForEach(Book.samples.filter { $0.status == "ongoing" }.prefix(2)) { book in
                NavigationLink(destination: MediaPlayerView(book: book)) {
                    HorizontalCard(book: book)
                }
                .buttonStyle(.plain)
            }
        }
        .padding()
    }
}


#Preview {
    OnGoingSubView()
}


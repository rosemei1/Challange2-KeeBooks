//
//  HorizontalCard.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

//import Foundation
import SwiftUI
import _SwiftData_SwiftUI

struct HorizontalCard: View {
    var book : Book
    
    @Environment(\.modelContext) private var modelContext
    @Query private var allBooks: [Book]
    
    
    func pickBook (_ book: Book) {
        for b in allBooks {
            b.isPicked = false
        }
        book.isPicked = true
    }
    
    private var progressValue: Double {

        let duration =
            Double(max(book.duration, 1))

        let bookmark =
            Double(book.bookmark ?? 0)

        return min(max(bookmark / duration, 0), 1)
    }
    
    
    var body: some View {
        HStack {
            Image(book.cover)
                .resizable()
                .frame(width: 67.5, height: 90)

            VStack(alignment: .leading) {
                Text(book.title)
                    .bold()
                    .foregroundStyle(.black)

                Text(book.author)
                    .font(.caption)
                    .foregroundStyle(Color.gray)

                ProgressView(value: progressValue)
                    .tint(.primary9)
                    .padding(.bottom, 32)
            }
            .padding(6)

            Button("Pick", systemImage: book.isPicked ? "checkmark.circle.fill" :"plus.circle") {
                pickBook(book)
            }
                .labelStyle(.iconOnly)
                .font(.title)
                .foregroundStyle(.primary9)
                .padding(6)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}


#Preview {
    HorizontalCard(        book: Book(
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

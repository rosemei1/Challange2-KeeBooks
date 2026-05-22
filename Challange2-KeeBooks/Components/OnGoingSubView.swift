//
//  OnGoingSubView.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

import SwiftUI
import SwiftData

struct OnGoingSubView: View {

    @Binding var chevron: Bool
    @Environment(\.modelContext) private var modelContext
    @Query private var allBooks: [Book]
    
    var pickedBook: Book? {
        allBooks.first{$0.isPicked}
    }

    var body: some View {
        VStack {
            HStack {
                Chevron(title: "On Going")
            }

            ForEach(allBooks.filter { $0.status == "ongoing" }.prefix(2)) { book in
                NavigationLink(destination: MediaPlayerView(book: book)) {
                    HorizontalCard(book: book)
                }
                .buttonStyle(.plain)
            }
        }
        .navigationDestination(isPresented: $chevron) {
            OnGoingView()
        }
        .padding()
    }
}


#Preview {
    OnGoingSubView(chevron: .constant(false))
        .modelContainer(Data.shared.modelContainer)
}

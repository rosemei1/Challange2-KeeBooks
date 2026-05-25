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
    @Query(sort: \Book.title) private var allBooks: [Book]
    @Binding var isDisabled: Bool
    
//    var pickedBook: Book? {
//        allBooks.first{$0.isPicked}
//    }
    
    var ongoingBooks: [Book] {
        allBooks.filter { $0.status == "ongoing" }
    }

    var body: some View {
        VStack {
            HStack {
                Chevron(title: "On Going", isDisabled: $isDisabled) {
                    chevron.toggle()
                }
            }
            
            if !ongoingBooks.isEmpty {
                ForEach(allBooks.filter { $0.status == "ongoing"}.prefix(3)) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        HorizontalCard(book: book)
                    }
//                    .buttonStyle(.plain)
                }
            } else {
                ContentUnavailableView("There is no ongoing book", systemImage: "books.vertical.fill", description: Text("You can start listening to an audiobook from library"))
            }
            

            
        }
        .navigationDestination(isPresented: $chevron) {
            OnGoingView()
        }
        .padding()
    }
}


#Preview {
    OnGoingSubView(chevron: .constant(false), isDisabled: .constant(true))
        .modelContainer(Data.shared.modelContainer)
}

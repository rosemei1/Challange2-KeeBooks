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
    @Query(sort: \Books.title) private var books: [Books]
    
    let columns = [
        GridItem(.flexible()),
    ]

    var body: some View {
        VStack {
            
            HStack (){
                Chevron(title: "On Going", action: {
                    chevron.toggle()
                })

            }
            LazyVGrid(columns: columns) {
                ForEach(books.prefix(3)) { book in
                    HorizontalCard(book: book)
                }
            }
//            HorizontalCard()
//            HorizontalCard()
        }
        .navigationDestination(isPresented: $chevron, destination: {
            OnGoingView()
        })
        .padding()
    }
}


#Preview {
    OnGoingSubView(chevron: .constant(false))
        .modelContainer(Data.shared.modelContainer)
}


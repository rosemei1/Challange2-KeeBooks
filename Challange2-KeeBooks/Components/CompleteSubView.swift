//
//  CompleteSubView.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

import Foundation
import SwiftUI
import SwiftData

struct CompleteSubView: View {
    
    @Binding var chevron: Bool
    @Query(sort: \Book.duration) private var books: [Book]
    @State var isDisabled = false
    
    var completedBook: [Book] {
        books.filter { $0.status == "completed" }
    }
    var array = Array(1...6)
    var body: some View {
        VStack {
            
            HStack (){
                Chevron(title: "Complete", isDisabled: $isDisabled, action: {
                    chevron.toggle()
                })
            }
            ScrollView (.horizontal){
                HStack{
                    if !completedBook.isEmpty {
                        ForEach(completedBook.prefix(3)) { book in
                            //                        VerticalCard(book: book)
                            NavigationLink(destination: DetailView(book: book)) {
                               VerticalCard(book: book)
                            }
                            
                        }
                    } else {
                        ContentUnavailableView("There is no book completed", systemImage: "books.vertical.fill", description: Text("You can Complete a book from library"))
//                            .foregroundStyle(.primary9)
                    }
                    
                }
                .scrollIndicators(.hidden)
            }
            .navigationDestination(isPresented: $chevron){
                FinishedView()
            }
            .padding()
        }
        .onAppear {
            isDisabled = completedBook.isEmpty
        }
        .onChange(of: books) {
            isDisabled = completedBook.isEmpty
        }
        .padding()

    }
    
}


#Preview {
    CompleteSubView(chevron: .constant(false))
        .modelContainer(Data.shared.modelContainer)
}


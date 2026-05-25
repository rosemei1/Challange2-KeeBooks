//
//  OnGoingView.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 22/05/26.
//

import SwiftUI
import SwiftData

struct OnGoingView: View {
//    let items = Array(1...6)
    var title: String
    var isOnGoingPage: Bool
    @Query(sort: \Book.title) private var books: [Book]
    
    let columns = [
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack{
                    LazyVGrid(columns: columns, spacing: 16){
                
                        ForEach((isOnGoingPage) ? books.filter { $0.status == "ongoing" } : books){ book in
                            NavigationLink(destination: DetailView(book: book)) {
                                HorizontalCard(book: book)
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
            .background {
                BackgroundView()
            }
        }
    }
}

#Preview {
    OnGoingView(title: "OnGoing", isOnGoingPage: true)
        .modelContainer(Data.shared.modelContainer)
}

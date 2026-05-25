//
//  FinishedView.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 22/05/26.
//

import SwiftUI
import SwiftData

struct FinishedView: View {
    
    @Query(sort: \Book.duration) private var books: [Book]
//    let items = Array(1...6)
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack{
                    LazyVGrid(columns: columns, spacing: 16){
                        ForEach(books){ book in
                            NavigationLink(destination: DetailView(book: book)) {
                                VerticalCard(book: book)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Finished")
            .navigationBarTitleDisplayMode(.inline)
            .background {
                BackgroundView()
            }
        }
    }
}

#Preview {
    FinishedView()
        .modelContainer(Data.shared.modelContainer)
        
}

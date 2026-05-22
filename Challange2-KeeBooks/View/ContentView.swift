//
//  ContentView.swift
//  Challange2-KeeBooks
//
//  Created by Irfan Hanif Khoiru Rijal on 20/05/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Books.title) private var books: [Books]

    var body: some View {
        
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView()
            }
            
            Tab("Library", systemImage: "books.vertical.fill") {
                LibraryView()
            }
            
            Tab("Activity", systemImage: "clock.fill") {
                ActivitylView()
            }
        }
        .tint(.primary9)
        .task {
            if books.isEmpty {
                for book in Books.booksData {
                    modelContext.insert(book)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [Books.self], inMemory: true)
}

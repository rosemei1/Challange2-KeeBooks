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
    @Query private var books: [Book]

    var body: some View {
        
        TabView {
            Tab("Home", systemImage: "house.fill") {
                HomeView()
                    .environment(\.modelContext, modelContext)
            }
            
            Tab("Library", systemImage: "books.vertical.fill") {
                LibraryView()
            }
            
            Tab("Activity", systemImage: "clock.fill") {
                ActivityView()
            }
        }
        .tint(.primary9)
        .task {
            if books.isEmpty {
                for book in Book.booksData {
                    modelContext.insert(book)
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(Data.shared.modelContainer)
}

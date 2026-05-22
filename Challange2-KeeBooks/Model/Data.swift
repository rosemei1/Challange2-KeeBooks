//
//  Data.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 22/05/26.
//

import Foundation
import SwiftData

class Data {
    static let shared = Data()
    
    let modelContainer: ModelContainer
    
    var context: ModelContext {
        modelContainer.mainContext
    }
    
    var books: Books {
        Books.booksData.first!
    }
    
    private init() {
        let schema = Schema([Books.self])
        
        let modelConfig = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfig])
            insertData()
            try context.save()
            

        } catch {
            fatalError("Failed to initialize bookData: \(error)")
        }
        
        func insertData() {
            for book in Books.booksData {
                context.insert(book)
            }
        }
    }
}

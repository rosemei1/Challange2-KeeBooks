//
//  Challange2_KeeBooksApp.swift
//  Challange2-KeeBooks
//
//  Created by Irfan Hanif Khoiru Rijal on 20/05/26.
//

import SwiftUI
import SwiftData

@main
struct Challange2_KeeBooksApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
        }
        .modelContainer(for: Books.self)
    }
}

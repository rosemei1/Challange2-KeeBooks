//
//  Books.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 20/05/26.
//

import Foundation
import SwiftData

@Model
class Books: Identifiable {
    var title: String
    var author: String
    var narrator: String
    var synopsis: String
    var duration: Int
    var status: String
    var bookmark: Int? = nil
    
    init(title: String, author: String, narrator: String, synopsis: String, duration: Int, status: String, bookmark: Int? = nil) {
        self.title = title
        self.author = author
        self.narrator = narrator
        self.synopsis = synopsis
        self.duration = duration
        self.status = status
        self.bookmark = bookmark
    }
}

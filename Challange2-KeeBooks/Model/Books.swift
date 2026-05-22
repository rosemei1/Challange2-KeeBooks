//
//  Books.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 20/05/26.
//

import Foundation
import SwiftData

@Model
class Books {
    var title: String
    var cover: String
    var audio: String
    var author: String
    var narrator: String
    var synopsis: String
    var duration: Int
    var status: String
    var bookmark: Int? = nil
    
    init(title: String, cover: String, audio: String, author: String, narrator: String, synopsis: String, duration: Int, status: String, bookmark: Int? = nil) {
        self.title = title
        self.cover = cover
        self.audio = audio
        self.author = author
        self.narrator = narrator
        self.synopsis = synopsis
        self.duration = duration
        self.status = status
        self.bookmark = bookmark
    }
    
    static let booksData = [
        Books(
            title: "",
            cover: "dune",
            audio: "",
            author: "",
            narrator: "",
            synopsis: "",
            duration: 0,
            status:""
        ),
        Books(
            title: "",
            cover: "dune",
            audio: "",
            author: "",
            narrator: "",
            synopsis: "",
            duration: 0,
            status:""
        ),
        Books(
            title: "",
            cover: "dune",
            audio: "",
            author: "",
            narrator: "",
            synopsis: "",
            duration: 0,
            status:""
        ),
        Books(
            title: "",
            cover: "dune",
            audio: "",
            author: "",
            narrator: "",
            synopsis: "",
            duration: 0,
            status:""
        ),
        Books(
            title: "",
            cover: "dune",
            audio: "",
            author: "",
            narrator: "",
            synopsis: "",
            duration: 0,
            status:""
        ),
        Books(
            title: "",
            cover: "dune",
            audio: "",
            author: "",
            narrator: "",
            synopsis: "",
            duration: 0,
            status:""
        ),
    ]

}


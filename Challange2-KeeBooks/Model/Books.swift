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
    var bookmark: Double? = nil
    
    init(title: String, cover: String, audio: String, author: String, narrator: String, synopsis: String, duration: Int, status: String, bookmark: Double? = nil) {
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
            title: "Beauty and the Monster",
            cover: "dune",
            audio: "Beauty and the Monster",
            author: "",
            narrator: "",
            synopsis: "",
            duration: 0,
            status:""
        ),
        Books(
            title: "By the Sea",
            cover: "dune",
            audio: "By the Sea",
            author: "",
            narrator: "",
            synopsis: "",
            duration: 0,
            status:""
        ),
        Books(
            title: "Morning in the West",
            cover: "dune",
            audio: "Morning in the West",
            author: "",
            narrator: "",
            synopsis: "",
            duration: 0,
            status:""
        ),
        Books(
            title: "Tale of the Witch Doll",
            cover: "dune",
            audio: "Tale of the Witch Doll",
            author: "",
            narrator: "",
            synopsis: "",
            duration: 0,
            status:""
        ),
        Books(
            title: "The Black Cat",
            cover: "dune",
            audio: "The Black Cat",
            author: "",
            narrator: "",
            synopsis: "",
            duration: 0,
            status:""
        ),
    ]

}


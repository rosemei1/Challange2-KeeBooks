//
//  Books.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 20/05/26.
//

import Foundation
import SwiftData

@Model
class Book: Identifiable {
    var title: String
    var cover: String
    var audio: String
    var author: String
    var narrator: String
    var synopsis: String
    var duration: Int
    var status: String
    var bookmark: Double? = nil
    var isPicked: Bool = false
    
    init(title: String, cover: String, audio: String, author: String, narrator: String, synopsis: String, duration: Int, status: String, bookmark: Double? = nil, isPicked: Bool = false) {
        self.title = title
        self.cover = cover
        self.audio = audio
        self.author = author
        self.narrator = narrator
        self.synopsis = synopsis
        self.duration = duration // in seconds
        self.status = status
        self.bookmark = bookmark
        self.isPicked = isPicked
    }
    
    static let booksData = [
        Book(
            title: "Beauty and the Monster",
            cover: "BookCover-TheBeautyAndTheMonster",
            audio: "Beauty and the Monster",
            author: "Stéphanie-Félicité de Genlis",
            narrator: "Mary Kay",
            synopsis: "A French theatrical adaptation of the famous fairy tale, The Beauty and the Monster is a drama of three characters - Beauty (Sabina), the Beast (Phanor) and Beauty's best friend, Phedima (the third wheel). - Summary by Mary Kay",
            duration: 491,
            status:"ongoing",
        ),
        Book(
            title: "By the Sea",
            cover: "BookCover-ByTheSea",
            audio: "By the Sea",
            author: "Heman White Chaplin",
            narrator: "Roger Melin",
            synopsis: "Questions of guardianship are posed in this interesting short story which takes place in a coastal village on Cape Cod. Would it be more beneficial for young Joseph to be raised to adulthood by a man of means with unquestioned character who could carve a successful future for him, or by a family member of lesser stature? Should the young lad have his own say in the matter? And what of the others who knew well of Joe's late mother's wishes? (Summary by Roger Melin)",
            duration: 4518,
            status:"ongoing",
        ),
        Book(
            title: "Morning in the West",
            cover: "BookCover-MorningInTheWest",
            audio: "Morning in the West",
            author: "Katherine Hale",
            narrator: "Various Narrators",
            synopsis: "This collection of verses by Canadian poet Katherine Hale takes a journey over Canada’s vast natural landscapes – prairies, forests and lakes. A special section presents the unique view points of women. - Summary by Larry Wilson",
            duration: 3146,
            status:"ongoing",
            isPicked: true
        ),
        Book(
            title: "Tale of the Witch Doll",
            cover: "BookCover-TaleOfTheWitchDoll",
            audio: "Tale of the Witch Doll",
            author: "Mildred A. Wirt Benson",
            narrator: "Amanda Leung",
            synopsis: "The first book in the Penny Parker Mystery Series. Written by the author of the Nancy Drew Mystery Series. - Summary by Amanda Leung",
            duration: 11829,
            status:"completed"
        ),
        Book(
            title: "The Black Cat",
            cover: "dune",
            audio: "The Black Cat",
            author: "Various Authors",
            narrator: "Various Narrators",
            synopsis: "The Black Cat (1895-1922) was a monthly literary magazine, publishing original short stories, often about uncanny or fantastical topics. Many writers were largely unknown, but some famous authors also wrote original material for this magazine.",
            duration: 6837,
            status:"completed"
        ),
    ]

}

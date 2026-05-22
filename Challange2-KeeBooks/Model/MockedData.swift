//
//  MockedData.swift
//  Challange2-KeeBooks
//
//  Created by Fuad Agus Salim on 22/05/26.
//

import Foundation

extension Book {
    static let samples: [Book] = [
        Book(
            title: "The Hunger Games",
            cover: "dummyBookCover",
            audio: "sample.mp3",
            author: "Suzanne Collins",
            narrator: "Carolyn McCormick",
            synopsis: "In a dystopian future, teenager Katniss Everdeen volunteers to take her sister's place in the Hunger Games, a televised death match between children.",
            duration: 3351,
            status: "unread"
        ),
        Book(
            title: "Dune",
            cover: "dummyBookCover",
            audio: "sample.mp3",
            author: "Frank Herbert",
            narrator: "Scott Brick",
            synopsis: "Set in the distant future, a noble family becomes embroiled in a war for the most valuable substance in the universe on a desert planet.",
            duration: 5400,
            status: "ongoing",
            bookmark: 1200
        ),
        Book(
            title: "1984",
            cover: "dummyBookCover",
            audio: "sample.mp3",
            author: "George Orwell",
            narrator: "Simon Prebble",
            synopsis: "A chilling vision of a totalitarian society where Big Brother watches your every move and independent thought is a crime.",
            duration: 3600,
            status: "completed"
        ),
        Book(
            title: "The Hobbit",
            cover: "dummyBookCover",
            audio: "sample.mp3",
            author: "J.R.R. Tolkien",
            narrator: "Rob Inglis",
            synopsis: "Bilbo Baggins, a homebody hobbit, is swept into an epic quest to reclaim a dwarf kingdom from the dragon Smaug.",
            duration: 4200,
            status: "unread"
        ),
        Book(
            title: "Harry Potter and the Sorcerer's Stone",
            cover: "dummyBookCover",
            audio: "sample.mp3",
            author: "J.K. Rowling",
            narrator: "Jim Dale",
            synopsis: "An orphaned boy discovers he is a wizard and begins his education at Hogwarts School of Witchcraft and Wizardry.",
            duration: 4800,
            status: "completed"
        ),
        Book(
            title: "Brave New World",
            cover: "dummyBookCover",
            audio: "sample.mp3",
            author: "Aldous Huxley",
            narrator: "Michael York",
            synopsis: "A futuristic society engineered for happiness at the cost of freedom, family, and authentic human experience.",
            duration: 3100,
            status: "ongoing",
            bookmark: 600
        ),
    ]
}

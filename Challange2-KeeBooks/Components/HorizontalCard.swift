//
//  HorizontalCard.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

//import Foundation
import SwiftUI

struct HorizontalCard: View {
    var book : Book
    var body: some View {
        Button (action: {}) {
            HStack{
                Image(book.cover)
                    .resizable()
                    .frame(width: 67.5, height: 90)
                
                
                VStack (alignment: .leading){
                    Text(book.title)
                        .font(.default)
                        .bold()
                        
                    
                    Text(book.author)
                        .font(.caption)
                    
                    ProgressView(value: 0.7)
                        .tint(.primary9)
                }
                .padding(6)
                
                Button("Pick", systemImage: "plus.circle", action: {})
                    .labelStyle(.iconOnly)
                    .font(.title)
                    .foregroundStyle(.primary9)
                    .padding(6)
                
            }
            .padding()
//                        .background(.background.secondary)
                        .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            
        }
        .buttonStyle(.plain)
    }
}


#Preview {
    HorizontalCard(        book: Book(
        title: "The Hunger Game",
        cover: "dune",
        audio: "sample.mp3",
        author: "Suzanne Collins",
        narrator: "The Assasins",
        synopsis: "",
        duration: 3351,
        status: "unread"
    )
)
}

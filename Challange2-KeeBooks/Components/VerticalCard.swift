//
//  VerticalCard.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

import Foundation
import SwiftUI

struct VerticalCard: View {
    @Bindable var book: Books
    var body: some View {
        VStack{
            Image(book.cover)
                .resizable()
                .frame(width: 90, height: 120)
                .padding(.top,6)

            VStack (alignment: .center){
                Text(book.title)
                    .font(.default)
                    .bold()

                Text(book.author)
                    .font(.caption)
            }
            .frame(width: 130, height: 70)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}


#Preview {
    VerticalCard(book: Books(title: "Dune", cover: "dune", audio: "", author: "Dune", narrator: "Dune", synopsis: "Lorem ipsum", duration: 0, status: "Done"))
}

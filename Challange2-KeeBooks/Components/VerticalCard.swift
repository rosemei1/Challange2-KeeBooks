//
//  VerticalCard.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

import Foundation
import SwiftUI

struct VerticalCard: View {
    var book: Book

    var body: some View {
        VStack {
            Image(book.cover)
                .resizable()
                .frame(width: 90, height: 120)
                .padding(.top, 6)

            VStack(alignment: .center) {
                Text(book.title)
                    .font(.default)
                    .bold()
                    .foregroundStyle(.black)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)

                Text(book.author)
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .lineLimit(1)
            }
            .frame(width: 130, height: 70)
        }
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}


#Preview {
    VerticalCard(book: Data.shared.books[0])
}

//
//  VerticalCard.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

import Foundation
import SwiftUI

struct VerticalCard: View {
    var body: some View {
        Button (action: {}) {
            VStack{
                Image("BookCover1")
                    .resizable()
                    .frame(width: 90, height: 120)
                    .padding(.top,6)
                
                
                VStack (alignment: .center){
                    Text("The Book Title")
                        .font(.default)
                        .bold()
                        
                    
                    Text("Author Name")
                        .font(.caption)
                    
                }
//                .padding(6)
                .frame(width: 130, height: 70)
                
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
    VerticalCard()
}

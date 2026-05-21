//
//  HorizontalCard.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

//import Foundation
import SwiftUI

struct HorizontalCard: View {
    var body: some View {
        Button (action: {}) {
            HStack{
                Image("BookCover1")
                    .resizable()
                    .frame(width: 67.5, height: 90)
                
                
                VStack (alignment: .leading){
                    Text("The Book Title")
                        .font(.default)
                        .bold()
                        
                    
                    Text("Author Name")
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
    HorizontalCard()
}

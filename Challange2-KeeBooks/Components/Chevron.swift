//
//  Chevron.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

import Foundation
import SwiftUI

struct Chevron: View {
    
    let title : String
    
    var body: some View {
        VStack {
            HStack (alignment: .center){
                Text(title)
                    .font(.title2)
                Button("More", systemImage: "chevron.right.circle", action: {})
                    .labelStyle(.iconOnly)
                    .font(.title)
                    .foregroundStyle(.primary9)
                Spacer()

            }
        }
    }
}


#Preview {
    Chevron(title: "On going")
}

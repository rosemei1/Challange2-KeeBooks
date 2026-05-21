//
//  OnGoingSubView.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

import SwiftUI

struct OnGoingSubView: View {
    var body: some View {
        VStack {
            
            HStack (){
                Text("On going")
                    .font(.title2)
                Button("More", systemImage: "chevron.right.circle", action: {})
                    .labelStyle(.iconOnly)
                Spacer()

            }
            HorizontalCard()
            HorizontalCard()
            HorizontalCard()
        }
        .padding()
    }
}


#Preview {
    OnGoingSubView()
}


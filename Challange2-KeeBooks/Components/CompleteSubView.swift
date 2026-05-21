//
//  CompleteSubView.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

import Foundation
import SwiftUI

struct CompleteSubView: View {
    var body: some View {
        VStack {
            
            HStack (){
                Text("Complete")
                    .font(.title2)
                Button("More", systemImage: "chevron.right.circle", action: {})
                    .labelStyle(.iconOnly)
                Spacer()

            }
            ScrollView (.horizontal){
                HStack{
                    VerticalCard()
                    VerticalCard()
                    VerticalCard()
                    VerticalCard()
                }
            }
        }
        .padding()
    }
}


#Preview {
    CompleteSubView()
}


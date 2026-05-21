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
                Chevron(title: "On Going")

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


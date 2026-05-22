//
//  OnGoingSubView.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

import SwiftUI

struct OnGoingSubView: View {
    
    @Binding var chevron: Bool

    var body: some View {
        VStack {
            
            HStack (){
                Chevron(title: "On Going", action: {
                    chevron.toggle()
                })

            }
            HorizontalCard()
            HorizontalCard()
            HorizontalCard()
        }
        .navigationDestination(isPresented: $chevron, destination: {
            OnGoingView()
        })
        .padding()
    }
}


#Preview {
    OnGoingSubView(chevron: .constant(false))
}


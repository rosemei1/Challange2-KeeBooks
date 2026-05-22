//
//  CompleteSubView.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

import Foundation
import SwiftUI

struct CompleteSubView: View {
    
    @Binding var chevron: Bool
    
    var array = Array(1...6)
    var body: some View {
        VStack {
            
            HStack (){
                Chevron(title: "Complete", action: {
                    chevron.toggle()
                })
            }
            ScrollView (.horizontal){
                LazyHStack {
                    ForEach(array, id: \.self) {_ in
                        VerticalCard()
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .navigationDestination(isPresented: $chevron){
            FinishedView()
        }
        .padding()
    }
}


#Preview {
    CompleteSubView(chevron: .constant(false))
}


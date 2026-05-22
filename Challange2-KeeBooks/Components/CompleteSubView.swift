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
                Chevron(title: "Complete")

            }
            ScrollView (.horizontal){
                HStack{
                    ForEach(Book.samples.filter { $0.status == "completed" }) { book in
                        VerticalCard(book: book)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding()
    }
}


#Preview {
    CompleteSubView()
}


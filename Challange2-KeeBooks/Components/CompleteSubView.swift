//
//  CompleteSubView.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

import Foundation
import SwiftUI
import SwiftData

struct CompleteSubView: View {
    
    @Binding var chevron: Bool
    @Query(sort: \Book.duration) private var books: [Book]
    
    var array = Array(1...6)
    var body: some View {
        VStack {
            
            HStack (){
                Chevron(title: "Complete", action: {
                    chevron.toggle()
                })
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
        .navigationDestination(isPresented: $chevron){
            FinishedView()
        }
        .padding()
    }
}


#Preview {
    CompleteSubView(chevron: .constant(false))
        .modelContainer(Data.shared.modelContainer)
}


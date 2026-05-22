//
//  OnGoingView.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 22/05/26.
//

import SwiftUI

struct OnGoingView: View {
    let items = Array(1...6)
    let columns = [
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack{
                    LazyVGrid(columns: columns, spacing: 16){
                        ForEach(items, id: \.self){ item in
                            HorizontalCard()
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("Ongoing")
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
            .background {
                BackgroundView()
            }
        }
    }
}

#Preview {
    OnGoingView()
}

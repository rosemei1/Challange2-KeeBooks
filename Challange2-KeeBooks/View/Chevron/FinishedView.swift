//
//  FinishedView.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 22/05/26.
//

import SwiftUI

struct FinishedView: View {
    let items = Array(1...6)
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack{
                    LazyVGrid(columns: columns, spacing: 16){
                        ForEach(items, id: \.self){ item in
                            VerticalCard()
                        }
                    }
                }
            }
            .navigationTitle("Finished")
            .navigationBarTitleDisplayMode(.inline)
            .background {
                BackgroundView()
            }
        }
    }
}

#Preview {
    FinishedView()
}

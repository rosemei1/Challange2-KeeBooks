//
//  ActivityView.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

import Foundation
import SwiftUI
import SwiftData

struct ActivityView: View {
    @State var chevron = false
    @State var chevronOngoing = false
    @State var isDisabled = false
    
    var body: some View {
        
        NavigationStack{
            ScrollView {
                OnGoingSubView(chevron: $chevronOngoing, isDisabled: $isDisabled)
                CompleteSubView(chevron: $chevron)
                Spacer()
            }
            .scrollIndicators(.hidden)
            
            
            
            
//            Navigation
                .navigationTitle("Activity")
                .background {
                    BackgroundView()
                }
        }
        .padding(.top, -85)
        
    }
}





#Preview {
    ActivityView()
//        .modelContainer(for: Book.self, inMemory: true)
        .modelContainer(Data.shared.modelContainer)
}

//
//  ActivitylView.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

import Foundation
import SwiftUI

struct ActivitylView: View {
    @State var chevron = false
    @State var chevronOngoing = false
    var body: some View {
        
        NavigationStack{
            ScrollView {
                OnGoingSubView(chevron: $chevronOngoing)
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
    ActivitylView()
}

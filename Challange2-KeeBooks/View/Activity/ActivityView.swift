//
//  ActivitylView.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

import Foundation
import SwiftUI

struct ActivitylView: View {
    var body: some View {
        
        NavigationStack{
            ScrollView {
                OnGoingSubView()
                CompleteSubView()
                Spacer()
            }
            .scrollIndicators(.hidden)
            
            
            
            
//            Navigation
                .navigationTitle("Activity")
                .background {
                    BackgroundView()
                }
        }
        
    }
}


#Preview {
    ActivitylView()
}

//
//  File.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

import Foundation
import SwiftUI

struct DetailView: View {
    var body: some View {
        
        NavigationStack{
            OnGoingSubView()
            CompleteSubView()
            Spacer()
            
            
            
            
//            Navigation
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .principal){
                        Text("Activity")
                    }
                }
        }
        
    }
}


#Preview {
    DetailView()
}

//
//  ContentView.swift
//  Challange2-KeeBooks
//
//  Created by Irfan Hanif Khoiru Rijal on 20/05/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            
            TabView {
                Tab("Home", systemImage: "house.fill") {
                    
                }
                
                Tab("Library", systemImage: "books.vertical.fill") {
                    
                }
                
                Tab("Activity", systemImage: "clock.fill") {
                    
                }
                
            }
        }
    }
}
#Preview {
    ContentView()
}

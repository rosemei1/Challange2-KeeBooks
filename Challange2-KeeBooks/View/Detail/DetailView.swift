//
//  DetailView.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 20/05/26.
//

import SwiftUI

struct DetailView: View {
    
    @State private var bookName: String = "Dune"
    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                VStack {
                    Image("dune")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 202, height: 308)
                        .background(.gray)
                        .padding(.top, 50)
                        .shadow(radius: 30)
                    
                    VStack {
                        Text(bookName)
                            .font(.title2).bold()
                        
                        Text("Author: Frank Herbert")
                            .font(.caption)
                            .fontWeight(.light)
                            .foregroundStyle(.secondary)
                        
                        Text("Narrator: David Lynch")
                            .font(.caption)
                            .fontWeight(.light)
                            .foregroundStyle(.secondary)
                        
                        Text("Duration: 1h 45m")
                            .font(.caption)
                            .fontWeight(.light)
                            .foregroundStyle(.secondary)
                        
                    }
                    HStack {
                        ButtonFilled(label: "Play", icon: "play.fill", width: 150) {
                            print("Test")
                        }
                        ButtonOutlined(label: "Pick", icon: "hand.tap.fill") {
                            print("Test")
                        }
                    }
                    
                    VStack {
                            Text("Synopsis:")
                            .font(.headline)
                            .bold()
                            .padding(.top, 16)
                              
                        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in nibh lacus.")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 32)
                    
                        
                }
            }
            .background {
                Color.primary1
                BackgroundView()
            }
        }
        
    }
}

#Preview {
    DetailView()
}

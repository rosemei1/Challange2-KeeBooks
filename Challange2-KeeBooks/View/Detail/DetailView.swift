//
//  DetailView.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 20/05/26.
//

import SwiftUI

struct DetailView: View {
    
    @Bindable var book: Book
    
    var formattedDuration: String {
        let duration = Duration.seconds(book.duration)
        return duration.formatted(.time(pattern: .hourMinuteSecond))
    }

    
    var body: some View {
        NavigationStack {
            
            ScrollView {
                VStack {
                    Image(book.cover)
                        .resizable()
                        .scaledToFit()
                        .background(.gray)
                        .padding(.top, 50)
                        .padding(.horizontal, 16)
                        .shadow(radius: 30)
                    
                    VStack {
                        Text(book.title)
                            .font(.title2).bold()
                        
                        Text("Author: \(book.author)")
                            .font(.caption)
                            .fontWeight(.light)
                            .foregroundStyle(.secondary)
                        
                        Text("Narrator: \(book.narrator)")
                            .font(.caption)
                            .fontWeight(.light)
                            .foregroundStyle(.secondary)
                        
                        Text("Duration: \(formattedDuration)")
                            .font(.caption)
                            .fontWeight(.light)
                            .foregroundStyle(.secondary)
                        
                    }
                    HStack {
                        ButtonOutlined(label: "Pick", icon: "hand.tap.fill") {
                            print("Test")
                        }
                        ButtonFilled(label: "Play", icon: "play.fill", width: 150) {
                            print("Test")
                        }
                        
                    }
                    
                    VStack {
                            Text("Synopsis")
                            .font(.headline)
                            .bold()
                            .padding(.top, 16)
                              
                        Text(book.synopsis)
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal, 32)
                    
                        
                }
            }
            .scrollIndicators(.hidden)
            .background {
                Color.primary1
                BackgroundView()
            }
        }
        
    }
}

#Preview {
    DetailView(book: Data.shared.books.first!)
}

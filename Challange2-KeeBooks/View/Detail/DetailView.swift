//
//  DetailView.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 20/05/26.
//

import SwiftUI
import _SwiftData_SwiftUI

struct DetailView: View {
    
    @Bindable var book: Book
    
    @State private var showPlayer = false
    @Query private var allBooks: [Book]
    
    func pickBook (_ book: Book) {
        for b in allBooks {
            b.isPicked = false
        }
        book.isPicked = true
    }
    
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
                        
                        Button {
                            showPlayer = true
                        } label: {
                            Label("Play", systemImage: "play.fill")
                                .foregroundStyle(.white)
                                .frame(width: 150, height: 35)
                                .background(.primary9)
                                .glassEffect(.regular, in: .capsule)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                        
                        ButtonOutlined(
                            label: "Pick",
                            icon: book.isPicked
                                ? "checkmark.circle.fill"
                                : "plus.circle"
                        ) {
                            pickBook(book)
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
                .scrollIndicators(.hidden)
                .background {
                    Color.primary1
                    BackgroundView()
                }
                .sheet(isPresented: $showPlayer, onDismiss: {
                    AudioPlayerManager.shared.pause()
                }) {
                    MediaPlayerView(book: book)
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                }
            }
            .background(Color.primary1)
        }
    }
}

#Preview {
    DetailView(book: Data.shared.books.first!)
}

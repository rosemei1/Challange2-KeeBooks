//
//  MediaPlayerView.swift
//  Challange2-KeeBooks
//
//  Created by Fuad Agus Salim on 20/05/26.
//

import SwiftUI

struct MediaPlayerView: View {
    
    var book: Books
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var isPlaying = false
    @State private var progress: Double = 0.7
    
    var body: some View {

        ZStack {
                
                BackgroundView()
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    
                    GeometryReader { geo in
                        
                        Image(book.cover)
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: geo.size.width,
                                height: geo.size.height
                            )
                            .clipped()
                    }
                    .frame(height: 430)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        
                        Text(book.title)
                            .font(.title)
                            .bold()
                        
                        Text(book.author)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top, 2)
                        
                        Text(book.narrator)
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .padding(.top, 10)
                        
                        GeometryReader { geo in
                            
                            ZStack(alignment: .leading) {
                                
                                Capsule()
                                    .fill(
                                        Color(
                                            .lightGray
                                        )
                                    )
                                    .frame(height: 6)
                                
                                Capsule()
                                    .fill(
                                        .primary9
                                    )
                                    .frame(
                                        width: geo.size.width * progress,
                                        height: 6
                                    )
                            }
                        }
                        .frame(height: 6)
                        .padding(.top, 10)
                        
                        HStack {
                            Text("13:51")
                            
                            Spacer()
                            
                            Text("-41:51")
                        }
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .padding(.top, 4)
                        
                        Divider()
                            .padding(.vertical, 14)
                        
                        // MARK: - Controls
                        HStack {
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "gobackward.10")
                                    .font(.system(size: 40))
                            }
                            
                            Spacer()
                            
                            Button {
                                isPlaying.toggle()
                            } label: {
                                Image(
                                    systemName: isPlaying
                                    ? "pause.fill"
                                    : "play.fill"
                                )
                                .font(.system(size: 48))
                            }
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Image(systemName: "goforward.10")
                                    .font(.system(size: 40))
                            }
                            
                            Spacer()
                        }
                        .foregroundStyle(.primary)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(.white)
                }
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 28,
                        style: .continuous
                    )
                )
                .shadow(
                    color: .black.opacity(0.25),
                    radius: 20,
                    x: 0,
                    y: 8
                )
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .navigationTitle("Player")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {

                ToolbarItem(placement: .navigationBarLeading) {

                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                }
            }
    }
}

#Preview {
    MediaPlayerView(
        book: Books(
            title: "The Hunger Game",
            cover: "dune",
            audio: "sample.mp3",
            author: "Suzanne Collins",
            narrator: "The Assasins",
            synopsis: "",
            duration: 3351,
            status: "unread"
        )
    )
}

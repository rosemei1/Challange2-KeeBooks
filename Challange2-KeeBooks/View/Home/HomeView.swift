//
//  HomeView.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 23/05/26.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @AppStorage("sleepTime")
    private var sleepTimeInterval: Double = 0
    
    @AppStorage("notificationBefore")
    private var notificationBefore: Double = 15
    
    @State private var isPresented: Bool = false
    
    @Environment(\.modelContext) private var modelContext
    @Query private var allBooks: [Book]
    
    @State private var bluetoothManager = BluetoothManager()
    
    var pickedBook: Book {
        allBooks.first {$0.isPicked}!
    }
    
    private var progressValue: Double {

        let duration =
            Double(max(pickedBook.duration, 1))

        let bookmark =
            Double(pickedBook.bookmark ?? 0)

        return min(max(bookmark / duration, 0), 1)
    }
    
    var formattedSleepTime: String {

        let date =
            Date(timeIntervalSince1970: sleepTimeInterval)

        let formatter =
            DateFormatter()

        formatter.timeStyle = .short

        return formatter.string(from: date)
    }
    
    var reminderTime: String {

        let sleepDate =
            Date(timeIntervalSince1970: sleepTimeInterval)

        let reminderDate =
            sleepDate.addingTimeInterval(
                TimeInterval(-notificationBefore * 60)
            )

        return reminderDate.formatted(
            date: .omitted,
            time: .shortened
        )
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                // MARK: - First Section
                VStack(alignment: .leading) {
                    HStack {
                        
                        ZStack {
                            Image(pickedBook.cover)
                                .resizable()
                                .frame(maxWidth: 165)
                                .frame(height: 250)
                                .background()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .padding(.top, 16)
                                .blur(radius: 35)
                                .opacity(0.7)
                            
                            Image(pickedBook.cover)
                                .resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .frame(maxWidth: 165)
                                .padding(.top, 16)
                        }
                        
                        VStack(alignment: .leading) {
                            Spacer()
                            
                            Text(pickedBook.title)
                                .font(.title2)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)

                            Text(pickedBook.author)
                                .font(.body)
                                .fontWeight(.ultraLight)
                                .fontDesign(.rounded)

                            
                            ProgressView(value: progressValue)
                                .tint(.primary9)
                                .padding(.bottom, 32)
                            
                            ButtonFilled(label: "Change Picked Book", icon: "", width: 190) {
                                OnGoingView(title: "Change Book", isOnGoingPage: false)
                            }
                            Spacer(minLength: 10)

                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    
                    Text("Tonight's Pick")
                        .font(.title)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .padding(.top , 16)
                        .padding(.leading, 16)
                    
                    Text("Will be automatically played tonight")
                        .font(.body)
                        .fontWeight(.ultraLight)
                        .fontDesign(.rounded)
                        .padding(.leading, 16)
                    
                        
                }
                .padding(.bottom, 16)
                
                Divider()
                    .padding(.horizontal, 16)
                
                // MARK: - Second Section
                VStack(alignment: .leading){
                    VStack{
                        Text("Want to change the time?")
                            .font(.title2)
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                    }
                    .frame(alignment: .leading)
                    HStack(alignment: .top, spacing: 16) {
                        
                        // MARK: - Rings
                        ZStack {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 110, height: 110)
                                .shadow(radius: 5)
                            Circle()
                                .fill(.primary9)
                                .frame(width: 92, height: 92)
                            
                            Circle()
                                .fill(Color.white)
                                .frame(width: 74, height: 74)
                            Text(formattedSleepTime)
                                .font(.title2)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .foregroundStyle(.primary9)
                        }.padding(.top, 26)
                        
                        // MARK: - Text
                        VStack(alignment: .trailing, spacing: 14) {
                            Text("This will play automatically if you're still awake at \(formattedSleepTime). We’ll remind you to put on your Apple Watch at \(reminderTime).")
                                .font(.body)
                                .fontDesign(.rounded)
                            
                            Button("Change Time") {
                                isPresented = !isPresented
                            }
                            .foregroundStyle(.white)
                            .frame(width: 200, height: 35)
                            .background(.primary9)
                            .glassEffect(.regular, in: .capsule)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        }
                    }
                    .padding(20)
                    .background(
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.white)
                            .shadow(radius: 5)
                    )
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .padding(.horizontal)
                .padding(.vertical, 16)
                
                Divider()
                    .padding(.horizontal, 16)
                
                
                // MARK: - Third Section
                VStack(alignment: .leading){
                    VStack{
                        Text("Connectivity")
                            .font(.title2)
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                    }
                    .frame(alignment: .leading)
                    HStack(alignment: .center, spacing: 16) {
                        
                        Image(systemName: "airplay.audio")
                            .font(.system(size: 50))
                            .foregroundStyle(.primary9)
                        
                        Text(bluetoothManager.isConnected ? "Device is connected to \(bluetoothManager.deviceName ?? "Bluetooth")" : "No device is connected")
                            .font(.body)
                            .fontDesign(.rounded)
                        
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 35)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .shadow(radius: 5)
                    )
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity
                )
                .padding(.horizontal)
                .padding(.vertical, 16)

            }
            .background {
                ZStack {
                    Color.primary1
                    Image("")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 406, height: 530)
                        .background(.secondary1)
                        .clipShape(.rect(bottomLeadingRadius: 42, bottomTrailingRadius: 42))
                        .offset(y: -230)
                    
                    LinearGradient(
                        colors: [
                            Color.primary1.opacity(0),
                            Color.primary1.opacity(0.2),
                            Color.primary1.opacity(0.9)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .clipShape(.rect(bottomLeadingRadius: 42, bottomTrailingRadius: 42))
                    .offset(y: -230)
                    .frame(height: 530)
                }
            }
            .navigationTitle("Home")
            .navigationBarBackButtonHidden()
            
            .scrollBounceBehavior(.basedOnSize)
            .scrollIndicators(.hidden)
            .navigationTitle("Home")
            .navigationBarBackButtonHidden()
            .sheet(isPresented: $isPresented) {
                SettingTimeView()
                    .background(.ultraThinMaterial)
                    .presentationBackground(.ultraThinMaterial)
                    .presentationCornerRadius(40)
            }
            .onAppear {
                
                SleepManager.shared.modelContext =
                        modelContext
                
                SleepManager.shared.pickedBook = pickedBook

                NotificationManager.shared
                    .onPlayAudiobook = {

                        AudioPlayerManager.shared.play(
                            book: pickedBook
                        )
                    }

                NotificationManager.shared
                    .scheduleSleepNotification(
                        book: pickedBook
                    )

                AudioPlayerManager.shared.allBooks = allBooks
            }

            .onChange(of: sleepTimeInterval) {

                NotificationManager.shared
                    .scheduleSleepNotification(
                        book: pickedBook
                    )
            }

            .onChange(of: allBooks) {

                AudioPlayerManager.shared.allBooks = allBooks
            }
            
        }
        .padding(.top, -85)
    }
    
}



#Preview {
    HomeView()
        .modelContainer(Data.shared.modelContainer)
}

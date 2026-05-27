import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var books: [Book]
    @StateObject var sleepManager = SleepManager.shared
    @AppStorage("isFirstTime") var isFirstTime = true

    @State private var showSimulationPlayer = false

    var pickedBook: Book? {
        books.first { $0.isPicked }
    }

    var body: some View {
        if isFirstTime {
            OnboardingView()
        } else {
            Group {
                Text(sleepManager.sleepText)

                Button("Start Sleep Detection") {
                    sleepManager.requestAuthorization()
                }

                Button("Check Latest Sleep Stage") {
                    sleepManager.fetchLatestSleepStage()
                }

                Button("Simulate Tonight's Pick") {
                    if let book = pickedBook {
                        AudioPlayerManager.shared.play(book: book)
                        showSimulationPlayer = true
                    }
                }
                
                TabView {
                    
                    Tab("Home", systemImage: "house.fill") {
                        
                        HomeView()
                            .environment(\.modelContext, modelContext)
                    }
                    
                    Tab("Library", systemImage: "books.vertical.fill") {
                        
                        LibraryView()
                    }
                    
                    Tab("Activity", systemImage: "clock.fill") {
                        
                        ActivityView()
                    }
                }
                .tint(.primary9)
                .sheet(isPresented: $showSimulationPlayer, onDismiss: {
                    AudioPlayerManager.shared.pause()
                }) {
                    if let book = pickedBook {
                        NavigationStack {
                            MediaPlayerView(book: book, isPreview: false)
                        }
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                        .presentationBackground(.ultraThinMaterial)
                    }
                }

                .task {
                    if books.isEmpty {
                        
                        for book in Book.booksData {
                            
                            modelContext.insert(book)
                        }
                    }
                    NotificationManager.shared.setupActions()
                    
                    await NotificationManager.shared
                        .requestPermission()
                    sleepManager.requestAuthorization()
                }
                
            }
        }
    }
}

#Preview {
    
    ContentView()
        .modelContainer(Data.shared.modelContainer)
}

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var books: [Book]
    @StateObject var sleepManager = SleepManager.shared
    @AppStorage("isFirstTime") var isFirstTime = true
    
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
                
                .task {
                    if books.isEmpty {
                        
                        for book in Book.booksData {
                            
                            modelContext.insert(book)
                        }
                    }
                    NotificationManager.shared.setupActions()
                    
                    await NotificationManager.shared
                        .requestPermission()
                }
                
            }
        }
    }
}

#Preview {
    
    ContentView()
        .modelContainer(Data.shared.modelContainer)
}

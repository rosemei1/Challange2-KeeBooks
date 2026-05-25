import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(\.modelContext)
    private var modelContext

    @Query
    private var books: [Book]

    var body: some View {

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

            // Insert sample data
            if books.isEmpty {

                for book in Book.booksData {

                    modelContext.insert(book)
                }
            }

            // Setup notifications
            NotificationManager.shared
                .setupActions()

            await NotificationManager.shared
                .requestPermission()
        }
    }
}

#Preview {

    ContentView()
        .modelContainer(Data.shared.modelContainer)
}

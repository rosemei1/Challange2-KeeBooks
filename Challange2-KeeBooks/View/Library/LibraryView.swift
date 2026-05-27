import SwiftUI
import SwiftData

struct LibraryView: View {
    @State private var selectedBook: Book? = nil

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    @Query private var allBooks: [Book]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(allBooks) { book in
                            NavigationLink(destination: DetailView(book: book, isPreview: true)) {
                                VerticalCard(book: book)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            
            .scrollIndicators(.hidden)
            .navigationTitle("Library")
            .background {
                BackgroundView()
            }
            .sheet(item: $selectedBook, onDismiss: {
                AudioPlayerManager.shared.pause()
            }) { book in
                NavigationStack {
                    MediaPlayerView(book: book, isPreview: true)
                }
                .presentationDetents([.fraction(0.85)])
                .presentationDragIndicator(.visible)
                .presentationBackground(.ultraThinMaterial)
            }
        }
        .padding(.top, -85)

    }
}


#Preview {
    LibraryView()
        .modelContainer(Data.shared.modelContainer)
}

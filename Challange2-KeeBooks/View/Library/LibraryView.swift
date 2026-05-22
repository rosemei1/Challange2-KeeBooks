import SwiftUI

struct LibraryView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(Book.samples) { book in
                            NavigationLink(destination: MediaPlayerView(book: book)) {
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
        }
    }
}


#Preview {
    LibraryView()
}

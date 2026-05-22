import SwiftUI
import SwiftData

struct LibraryView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
//        let items = Array(1...6)
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]

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
//            .toolbarVisibility(.hidden, for: .bottomBar)
            
            .scrollIndicators(.hidden)
            .navigationTitle("Library")
            .background {
                BackgroundView()
            }
        }
        .padding(.top, -85)
//        .offset(y: -50)

    }
}


#Preview {
    LibraryView()
        .modelContainer(Data.shared.modelContainer)
}

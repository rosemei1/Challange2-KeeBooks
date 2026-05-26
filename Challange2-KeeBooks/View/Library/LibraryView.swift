import SwiftUI
import SwiftData

struct LibraryView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    @Query private var allBooks: [Book]

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
                        ForEach(allBooks) { book in
                            NavigationLink(destination: DetailView(book: book)) {
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
        .padding(.top, -85)

    }
}


#Preview {
    LibraryView()
        .modelContainer(Data.shared.modelContainer)
}

import SwiftUI

struct LibraryView: View {
    private let dummyBook = Books(
        title: "The Book Title",
        cover: "dummyBookCover",
        audio: "sample.mp3",
        author: "Author Name",
        narrator: "Narrator",
        synopsis: "",
        duration: 3600,
        status: "unread"
    )

    var body: some View {
        let items = Array(1...6)
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]

        NavigationStack {
            ScrollView{
                VStack{
                    LazyVGrid(columns: columns, spacing: 16){
                        ForEach(items, id: \.self){ item in
                            NavigationLink(destination: MediaPlayerView(book: dummyBook)) {
                                VerticalCard()
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

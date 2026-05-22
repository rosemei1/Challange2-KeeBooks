import SwiftUI

struct LibraryView: View {
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
                            VerticalCard()
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
}

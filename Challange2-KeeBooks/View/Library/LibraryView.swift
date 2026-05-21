import SwiftUI

struct LibraryView: View {
    var body: some View {
        let items = Array(1...6)
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
        ]
        
        ScrollView{
            VStack{
                VStack{
                    Text("Library")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .fontDesign(.rounded)
                        .padding(.horizontal)
                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .topLeading
                )
                LazyVGrid(columns: columns, spacing: 16){
                    ForEach(items, id: \.self){
                        item in VerticalCard()
                    }
                }
            }
        }
    }
}


#Preview {
    LibraryView()
}

import SwiftUI
import _SwiftData_SwiftUI

struct HomeView: View {
    
    @State private var isPresented: Bool = false
    
    @Environment(\.modelContext) private var modelContext
    @Query private var allBooks: [Book]
    
    var pickedBook: Book {
        allBooks.first {$0.isPicked}!
    }
    
    var body: some View {
        GeometryReader { proxy in
            NavigationStack {
                ScrollView {
                    
                    VStack(spacing: 40){
                        // MARK: - Title
                        VStack(alignment: .leading) {
                            Text("Home")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                                .padding(.horizontal)
                                .hidden()
                            
                            Spacer()
                                .frame(height: 250)
                                .background(Color.green)
                            
                            // MARK: - Pick
                            VStack(alignment: .leading, spacing: 6) {
                                
                                Text("Tonight's Pick")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                                

//                                Text("Total books: \(allBooks.count)")
//                                Text("Picked: \(allBooks.filter { $0.isPicked }.count)")
                                
//                                if let pick = pickedBook {
                                    Text("\(pickedBook.title)")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .fontDesign(.rounded)
                                    
                                    Text("\(pickedBook.author)")
                                        .font(.title3)
                                        .fontWeight(.thin)
                                        .fontDesign(.rounded)
//                                } else {
//                                    Text("No book picked yet")
//                                        .font(.title3)
//                                        .fontWeight(.thin)
//                                        .fontDesign(.rounded)
//                                    Text("")
//                                    Text("")
//                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.vertical, 3)
                            .background(
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(0),
                                        Color.white.opacity(0.95)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                        }
                        .frame(minWidth: proxy.size.width)
                        .padding(.top, proxy.safeAreaInsets.top)
                        .padding(.leading, proxy.safeAreaInsets.leading)
                        .padding(.trailing, proxy.safeAreaInsets.trailing)
                        .frame(minHeight: 200)
                        .background(alignment: .top) {
                            ZStack {
                                Image(pickedBook.cover)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(
                                        width: proxy.size.width,
                                        height: 465
                                    )
                                    .clipped()
                                
                                LinearGradient(
                                    colors: [
                                        Color.white.opacity(1),
                                        Color.white.opacity(0.5),
                                        Color.white.opacity(0.2),
                                        Color.white.opacity(0.5),
                                        Color.white.opacity(1)
                                    ],
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .frame(height: 465)
                            }
                            .ignoresSafeArea()
                        }
                        // MARK: - Second Section
                        VStack(alignment: .leading){
                            VStack{
                                Text("Want to change the time?")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                            }
                            .frame(alignment: .leading)
                            HStack(alignment: .top, spacing: 16) {
                                
                                // MARK: - Rings
                                ZStack {
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 110, height: 110)
                                        .shadow(radius: 5)
                                    Circle()
                                        .fill(.primary9)
                                        .frame(width: 92, height: 92)
                                    
                                    Circle()
                                        .fill(Color.white)
                                        .frame(width: 74, height: 74)
                                    Text("9:45")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .fontDesign(.rounded)
                                        .foregroundStyle(.primary9)
                                }.padding(.top, 26)
                                
                                // MARK: - Text
                                VStack(alignment: .trailing, spacing: 14) {
                                    Text("This will play automatically if you're still awake at 10:00 PM. We’ll remind you to put on your Apple Watch at 9:30 PM.")
                                        .font(.body)
                                        .fontDesign(.rounded)
                                    
                                    ButtonFilled(label: "Change Time", icon: "", width: 200) {
                                        isPresented = !isPresented
                                    }
                                }
                            }
                            .padding(20)
                            .background(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.white)
                                    .shadow(radius: 5)
                            )
                        }
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity
                        )
                        .padding(.horizontal)
                        
                        // MARK: - Third Section
                        VStack(alignment: .leading){
                            VStack{
                                Text("Connectivity")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                            }
                            .frame(alignment: .leading)
                            HStack(alignment: .center, spacing: 16) {
                                
                                Image(systemName: "airplay.audio")
                                    .font(.system(size: 50))
                                    .foregroundStyle(.primary9)
                                
                                Text("Device is connected to alexa")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .fontDesign(.rounded)
                                
                            }
                            .padding(.vertical, 20)
                            .padding(.horizontal, 35)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white)
                                    .shadow(radius: 5)
                            )
                        }
                        .frame(
                            maxWidth: .infinity,
                            maxHeight: .infinity
                        )
                        .padding(.horizontal)
                    }
                }
                .scrollBounceBehavior(.basedOnSize)
                .scrollIndicators(.hidden)
                .ignoresSafeArea(edges: [.top, .leading, .trailing])
                .navigationTitle("Home")
                .sheet(isPresented: $isPresented) {
                    SettingTimeView()
                    
                        .background(.ultraThinMaterial)
                        .presentationBackground(.ultraThinMaterial)
                        .presentationCornerRadius(40)
                    
                    
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .modelContainer(Data.shared.modelContainer)
}

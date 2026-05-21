import SwiftUI

struct HomeView: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 40){
                    // MARK: - Title
                    VStack(alignment: .leading) {
                        Text("Home")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .fontDesign(.rounded)
                            .padding(.horizontal)
                        
                        Spacer()
                            .frame(height: 250)
                            .background(Color.green)
                        
                        // MARK: - Pick
                        VStack(alignment: .leading, spacing: 6) {
                            
                            Text("Tonight's Pick")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                            
                            Text("Dune")
                                .font(.title)
                                .fontWeight(.bold)
                                .fontDesign(.rounded)
                            
                            Text("Frank Herbert")
                                .font(.title3)
                                .fontWeight(.thin)
                                .fontDesign(.rounded)
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
                            Image("dune")
                                .resizable()
                                .scaledToFill()
                                .frame(
                                    width: proxy.size.width,
                                    height: 465
                                )
                                .clipped()
                            
                            LinearGradient(
                                colors: [
                                    Color.white.opacity(0.3),
                                    Color.white.opacity(0.5)
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
                                    .fill(Color.orange)
                                    .frame(width: 92, height: 92)
                                
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 74, height: 74)
                                Text("9:45")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .fontDesign(.rounded)
                                    .foregroundStyle(.orange)
                            }.padding(.top, 26)
                            
                            // MARK: - Text
                            VStack(alignment: .leading, spacing: 14) {
                                Text("This will play automatically if you're still awake at 10:00 PM. We’ll remind you to put on your Apple Watch at 9:30 PM.")
                                    .font(.body)
                                    .fontDesign(.rounded)
                                
                                Button {
                                    isPresented = !isPresented
                                } label: {
                                    Text("Change Time")
                                        .fontDesign(.rounded)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 12)
                                        .background(Color.orange)
                                        .clipShape(
                                            RoundedRectangle(cornerRadius: 14)
                                        )
                                        .shadow(radius: 5)
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
                                .foregroundStyle(Color.orange)
                            
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
            .ignoresSafeArea(edges: [.top, .leading, .trailing])
            .sheet(isPresented: $isPresented) {
                SettingTimeView()
                
                    .background(.ultraThinMaterial)
                    .presentationBackground(.ultraThinMaterial)
                    .presentationCornerRadius(40)
                
                
            }
            
            
            
            
        }
    }
}

#Preview {
    HomeView()
}

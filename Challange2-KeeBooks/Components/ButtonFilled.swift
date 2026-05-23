import SwiftUI

struct ButtonFilled<Destination: View>: View {
    
    var label: String
    var icon: String
    var width: CGFloat
    
    @ViewBuilder var destination: Destination
    
    var body: some View {
        
        NavigationLink {
            destination
        } label: {
            
            Label(label, systemImage: icon)
                .foregroundStyle(.white)
                .frame(width: width, height: 35)
                .background(.primary9)
                .glassEffect(.regular, in: .capsule)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

#Preview {
    NavigationStack {
        ButtonFilled(
            label: "Play",
            icon: "play.fill",
            width: 150
        ) {
            Text("Destination View")
        }
    }
}

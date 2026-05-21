//
//  ButtonFilled.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 20/05/26.
//

import SwiftUI

struct ButtonFilled: View {
    
    var label: String
    var icon: String
    var width: CGFloat
    var action: () -> Void = {}
    
    var body: some View {
        Button(label, systemImage: icon) {
            action()
        }
        .foregroundStyle(.white)
        .frame(width: width, height: 35)
        .background(.primary9)
        .glassEffect(.regular, in: .capsule)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    ButtonFilled(label: "Play", icon: "play.fill", width: 150)
}

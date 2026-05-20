//
//  ButtonOutlined.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 20/05/26.
//

import SwiftUI

struct ButtonOutlined: View {
    
    var label: String
    var icon: String
    var action: () -> Void = { }
    
    var body: some View {
        Button(label, systemImage: icon) {
            action()
        }
        .foregroundStyle(.primary9)
        .frame(width: 150, height: 35)
        .overlay(RoundedRectangle(cornerRadius: 30).stroke( .primary9, lineWidth: 2))

    }
}

#Preview {
    ButtonOutlined(label:"Play", icon:"play.fill")
}

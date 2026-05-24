//
//  Chevron.swift
//  Challange2-KeeBooks
//
//  Created by Nadia Putri Natali Lubis on 20/05/26.
//

import Foundation
import SwiftUI

struct Chevron: View {
    
    let title : String
    @Binding var isDisabled: Bool
    var action: () -> Void = {}

    var body: some View {
        VStack {
            HStack (alignment: .center){
                Text(title)
                    .font(.title2)
                Button("More", systemImage: "chevron.right.circle",) {
                    action()
                }
                    .labelStyle(.iconOnly)
                    .font(.title)
                    .foregroundStyle((isDisabled) ? Color.gray :.primary9)
                    .disabled(isDisabled)
                Spacer()

            }
        }
    }
}


#Preview {
    Chevron(title: "On going", isDisabled: .constant(true))
}

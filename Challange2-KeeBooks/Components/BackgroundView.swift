//
//  BackgroundView.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 20/05/26.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Image("")
            .resizable()
            .scaledToFit()
            .frame(width: 406, height: 345)
            .background(.secondary1)
            .clipShape(.rect(bottomLeadingRadius: 42, bottomTrailingRadius: 42))
            .offset(y: -300)
            .blur(radius: 10)
    }
}

#Preview {
    BackgroundView()
}

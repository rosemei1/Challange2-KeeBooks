//
//  OnboardingView.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 25/05/26.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to KeeBooks")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.primary9)
                    .padding()
                    .padding(.top, 32)
                
                Image(systemName: "airplay.audio")
                    .font(Font.system(size: 220))
                    .foregroundStyle(.primary9)
                    .padding(.top, 64)
                
                Text("Connect to Alexa for the best sound experience. Once connected, you can leave your phone aside and enjoy hands-free control anytime.")
                    .font(.body)
                    .fontWeight(.thin)
                    .multilineTextAlignment(.center)
                    .padding(.top, 16)
                    .padding(.horizontal, 24)
                Spacer()
                ButtonFilled(label: "Get Started", icon: "", width: 350) {
                    SetPreferenceView()
                }
                .padding(.bottom, 16)
            }
            .background {
                Color.primary1
                
            }
        }
    }
}

#Preview {
    OnboardingView()
}

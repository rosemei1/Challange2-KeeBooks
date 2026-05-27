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
                    .font(Font.system(size: 120))
                    .foregroundStyle(.primary9)
                    .padding(.top)
                
                Text("Connect to Alexa for the best sound experience. Once connected, you can leave your phone aside and enjoy hands-free control anytime.")
                    .font(.body)
                    .fontWeight(.thin)
                    .multilineTextAlignment(.center)
                    .padding(.top, 16)
                    .padding(.horizontal, 24)
                
                Image(systemName: "bed.double.fill")
                    .font(Font.system(size: 120))
                    .foregroundStyle(.primary9)
                    .padding(.top)
                
                Text("To add an app to Sleep mode exceptions on iPhone open \(Text("Settings").foregroundStyle(.primary9).bold()) go to \(Text("Focus").foregroundStyle(.primary9).bold()) select \(Text("Sleep").foregroundStyle(.primary9).bold()) then tap \(Text("Choose Apps").foregroundStyle(.primary9).bold() ) tap \(Text("KeeBooks").foregroundStyle(.primary9).bold() ) under Allowed Notifications to allow and tap \(Text("Done").foregroundStyle(.primary9).bold() ).")
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
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
}

#Preview {
    OnboardingView()
}

//
//  SetPreferenceView.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 20/05/26.
//

import SwiftUI

struct SetPreferenceView: View {
    
    @AppStorage("isFirstTime") var isFirstTime = true

    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    BackgroundView()
                    SettingTime()
                }
            }
            .navigationTitle("Set your Sleep Time")
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", systemImage: "checkmark") {
                        isFirstTime = false
                    }
                    .tint(.primary9)
                }
            }
        }
    }
}

#Preview {
    SetPreferenceView()
}

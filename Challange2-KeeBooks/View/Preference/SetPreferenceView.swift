//
//  SetPreferenceView.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 20/05/26.
//

import SwiftUI

struct SetPreferenceView: View {
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    BackgroundView()
                    SettingTime()
                }
            }
            .navigationTitle("Set your Sleep Time")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", systemImage: "checkmark") {
                        
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

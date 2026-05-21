//
//  SettingTimeView.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 20/05/26.
//

import SwiftUI

struct SettingTimeView: View {
    
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        NavigationStack {
            VStack {
                SettingTime()
            }
            .navigationTitle("Set your sleep time")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save", systemImage: "checkmark") {
                        dismiss()
                    }
                    .tint(.primary9)
                
                }
                
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", systemImage: "xmark") {
                        dismiss()
                    }
                    .tint(.red)
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.clear)
        }
        
    }
}

#Preview {
    SettingTimeView()
}

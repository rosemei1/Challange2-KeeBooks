//
//  SettingTime.swift
//  Challange2-KeeBooks
//
//  Created by Muhammad Alief Rahman Fardillah on 20/05/26.
//

import SwiftUI

struct SettingTime: View {
    
    @State private var selectedNotification = 15
    let notifications: [Int] = [15, 30, 45, 60]
    
    var body: some View {
        Form {
            Section {
                Text("Sleep Time")
                    .font(.title3)
                    .bold()
                
                DatePicker("", selection: .constant(Date()), displayedComponents: .hourAndMinute).datePickerStyle(.wheel)
                
                Spacer()
                
                Picker("Notify to pickup phone", selection: $selectedNotification) {
                    ForEach(notifications, id: \.self) { notification in
                        Text("\(notification) minutes before")
                        
                    }
                }
                .pickerStyle(.inline)
            }

        }
        .scrollContentBackground(.hidden)
        .background(.ultraThinMaterial)
        
    }
}


#Preview {
    SettingTime()
}

import SwiftUI

struct SettingTime: View {

    @AppStorage("sleepTime")
    private var sleepTimeInterval: Double = Date().timeIntervalSince1970

    @AppStorage("notificationBefore")
    private var selectedNotification = 15

    let notifications: [Int] = [15, 30, 45, 60]

    private var sleepTimeBinding: Binding<Date> {
        Binding(
            get: {
                Date(timeIntervalSince1970: sleepTimeInterval)
            },
            set: { newValue in
                sleepTimeInterval = newValue.timeIntervalSince1970
            }
        )
    }

    var body: some View {

        ZStack {

            Color.clear

            List {

                Section {

                    Text("Sleep Time")
                        .font(.title3)
                        .bold()

                    DatePicker(
                        "",
                        selection: sleepTimeBinding,
                        displayedComponents: .hourAndMinute
                    )
                    .datePickerStyle(.wheel)

                    Picker(
                        "Notify to pickup phone",
                        selection: $selectedNotification
                    ) {

                        ForEach(notifications, id: \.self) { notification in

                            Text("\(notification) minutes before")
                        }
                    }
                    .pickerStyle(.inline)
                }
            }
            .scrollContentBackground(.hidden)
            .background(.clear)
        }
    }
}

#Preview {
    SettingTime()
}

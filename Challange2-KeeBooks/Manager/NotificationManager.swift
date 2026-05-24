import Foundation
import UserNotifications
import Combine

@MainActor
final class NotificationManager:
    NSObject,
    ObservableObject,
    UNUserNotificationCenterDelegate {

    static let shared = NotificationManager()

    // MARK: - Request Permission

    func requestPermission() async {

        do {

            try await UNUserNotificationCenter
                .current()
                .requestAuthorization(
                    options: [
                        .alert,
                        .badge,
                        .sound
                    ]
                )

        } catch {

            print(error.localizedDescription)
        }
    }

    // MARK: - Setup Actions

    func setupActions() {

        let playAction =
            UNNotificationAction(
                identifier: "PLAY_AUDIOBOOK",
                title: "Play"
            )

        let category =
            UNNotificationCategory(
                identifier: "AUDIOBOOK_CATEGORY",
                actions: [playAction],
                intentIdentifiers: []
            )

        UNUserNotificationCenter.current()
            .setNotificationCategories(
                [category]
            )
    }

    // MARK: - Send Notification

    func sendPlayNotification(
        book: Book
    ) {

        let content =
            UNMutableNotificationContent()

        content.title =
            "Still Awake?"

        content.body =
            "Continue listening to \(book.title)?"

        content.sound = .default

        content.categoryIdentifier =
            "AUDIOBOOK_CATEGORY"

        content.userInfo = [
            "bookTitle": book.title
        ]

        let trigger =
            UNTimeIntervalNotificationTrigger(
                timeInterval: 1,
                repeats: false
            )

        let request =
            UNNotificationRequest(
                identifier: UUID().uuidString,
                content: content,
                trigger: trigger
            )

        UNUserNotificationCenter.current()
            .add(request)
    }
}

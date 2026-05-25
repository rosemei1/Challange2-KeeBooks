//
//  NotificationManager.swift
//  Challange2-KeeBooks
//

import Foundation
import UserNotifications
import Combine

@MainActor
final class NotificationManager:
    NSObject,
    ObservableObject,
    UNUserNotificationCenterDelegate {

    static let shared = NotificationManager()

    // CALLBACK
    var onPlayAudiobook: (() -> Void)?

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

    // MARK: - Setup Notification Actions

    func setupActions() {

        // PLAY BUTTON
        let playAction =
            UNNotificationAction(
                identifier: "PLAY_AUDIOBOOK",
                title: "Play"
            )

        // NO BUTTON
        let noAction =
            UNNotificationAction(
                identifier: "DISMISS_AUDIOBOOK",
                title: "No"
            )

        // CATEGORY
        let category =
            UNNotificationCategory(
                identifier: "AUDIOBOOK_CATEGORY",
                actions: [
                    playAction,
                    noAction
                ],
                intentIdentifiers: []
            )

        // REGISTER CATEGORY
        UNUserNotificationCenter.current()
            .setNotificationCategories(
                [category]
            )

        // SET DELEGATE
        UNUserNotificationCenter.current()
            .delegate = self
    }

    // MARK: - Schedule Sleep Notification

    func scheduleSleepNotification(
        book: Book
    ) {

        // REMOVE OLD NOTIFICATION
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(
                withIdentifiers: [
                    "sleepReminder"
                ]
            )

        // GET SAVED SLEEP TIME
        let sleepTimeInterval =
            UserDefaults.standard.double(
                forKey: "sleepTime"
            )

        let sleepDate =
            Date(
                timeIntervalSince1970:
                    sleepTimeInterval
            )

        // EXTRACT HOUR & MINUTE
        let components =
            Calendar.current.dateComponents(
                [
                    .hour,
                    .minute
                ],
                from: sleepDate
            )

        // CONTENT
        let content =
            UNMutableNotificationContent()

        content.title =
            "Still Awake?"

        content.body =
            "Continue listening to \(book.title)?"

        content.sound =
            .default

        content.categoryIdentifier =
            "AUDIOBOOK_CATEGORY"

        // TRIGGER
        let trigger =
            UNCalendarNotificationTrigger(
                dateMatching: components,
                repeats: true
            )

        // REQUEST
        let request =
            UNNotificationRequest(
                identifier: "sleepReminder",
                content: content,
                trigger: trigger
            )

        // SCHEDULE
        UNUserNotificationCenter.current()
            .add(request)
    }

    // MARK: - Notification Actions

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse
    ) async {

        switch response.actionIdentifier {

        case "PLAY_AUDIOBOOK":

            print("Play audiobook tapped")

            onPlayAudiobook?()

        case "DISMISS_AUDIOBOOK":

            print("No tapped")

        default:
            break
        }
    }

    // MARK: - Show Notification While App Open

    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification
    ) async -> UNNotificationPresentationOptions {

        return [
            .banner,
            .sound
        ]
    }
}

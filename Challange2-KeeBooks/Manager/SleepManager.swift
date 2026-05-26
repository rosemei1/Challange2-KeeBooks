import Foundation
import HealthKit
import CoreMotion
import SwiftUI
import Combine
import SwiftData

@MainActor
final class SleepManager: ObservableObject {
    
    @AppStorage("sleepTime")
    private var sleepTimeInterval: Double = 0
    
    var modelContext: ModelContext?

//    @Query private var allBooks: [Book]
    
//    var pickedBook: Book? {
//        allBooks.first {$0.isPicked}
//    }
    var pickedBook: Book?
    
    var formattedSleepTime: String {

        let date =
            Date(timeIntervalSince1970: sleepTimeInterval)

        let formatter =
            DateFormatter()

        formatter.timeStyle = .short

        return formatter.string(from: date)
    }

    static let shared = SleepManager()

    // MARK: - HealthKit

    private let healthStore = HKHealthStore()

    // MARK: - Motion

    private let motionManager =
        CMMotionActivityManager()

    // MARK: - Timer

    private var monitoringTimer: Timer?

    // MARK: - Published UI

    @Published var sleepText =
        "Not Monitoring"

    // MARK: - State

    private var lowMovementCount = 0

    private var latestHeartRate: Double = 0

    private init() {}

    // MARK: - Authorization

    func requestAuthorization() {

        guard HKHealthStore
            .isHealthDataAvailable()
        else {

            sleepText =
                "HealthKit unavailable"

            return
        }

        let readTypes: Set<HKObjectType> = [

            HKObjectType.categoryType(
                forIdentifier: .sleepAnalysis
            )!,

            HKObjectType.quantityType(
                forIdentifier: .heartRate
            )!
        ]

        healthStore.requestAuthorization(
            toShare: [],
            read: readTypes
        ) { success, error in

            DispatchQueue.main.async {

                if let error = error {

                    self.sleepText =
                        error.localizedDescription

                    return
                }

                if success {

                    self.sleepText =
                        "Permission Granted"

                    self.startMonitoring()

                } else {

                    self.sleepText =
                        "Permission Denied"
                }
            }
        }
    }

    // MARK: - Start Monitoring

    func startMonitoring() {

        monitoringTimer?.invalidate()

        sleepText =
            "Monitoring Sleep..."

        monitoringTimer =
            Timer.scheduledTimer(
                withTimeInterval: 10,
                repeats: true
            ) { _ in

                self.checkSleepState()
            }
    }

    // MARK: - Stop Monitoring

    func stopMonitoring() {

        monitoringTimer?.invalidate()

        monitoringTimer = nil

        sleepText =
            "Monitoring Stopped"
    }
    
    // MARK: - RestingBPM
    
//    private func fetchRestingBPM() -> Double {
//        guard let restingHeartRateType =
//                HKQuantityType.quantityType(
//                    forIdentifier: .restingHeartRate
//                )
//        else {
//            return 0
//        }
//        
//        let query = HKSampleQuery(
//            sampleType: restingHeartRateType,
//            predicate: nil,
//            limit: 1,
//            sortDescriptors: [
//                
//                NSSortDescriptor(
//                    key: HKSampleSortIdentifierEndDate,
//                    ascending: false
//                )
//            ]
//        ) { _, samples, error in
//            
//            guard error == nil else {
//                return
//            }
//            
//            guard let sample =
//                    samples?.first
//                    as? HKQuantitySample
//            else {
//                return
//            }
//            
//            let unit =
//            HKUnit.count()
//                .unitDivided(
//                    by: HKUnit.minute()
//                )
//            
//            let bpm =
//            sample.quantity.doubleValue(
//                for: unit
//            )
//            
//           return bpm
//        }
//    }

    // MARK: - Night Time Check

    private func isSleepTime() -> Bool {

        let calendar = Calendar.current

        let now = Date()

        let sleepDate =
            Date(timeIntervalSince1970: sleepTimeInterval)

        let nowComponents =
            calendar.dateComponents(
                [.hour, .minute],
                from: now
            )

        let sleepComponents =
            calendar.dateComponents(
                [.hour, .minute],
                from: sleepDate
            )

        let currentMinutes =
            (nowComponents.hour ?? 0) * 60 +
            (nowComponents.minute ?? 0)

        let sleepMinutes =
            (sleepComponents.hour ?? 0) * 60 +
            (sleepComponents.minute ?? 0)


        if sleepMinutes > 720 {

            return currentMinutes >= sleepMinutes ||
                   currentMinutes <= 360
        }

        return currentMinutes >= sleepMinutes
    }

    // MARK: - Heart Rate

    func fetchHeartRate(
        completion: @escaping (Double) -> Void
    ) {

        guard let heartRateType =
            HKQuantityType.quantityType(
                forIdentifier: .heartRate
            )
        else {
            return
        }

        let query = HKSampleQuery(
            sampleType: heartRateType,
            predicate: nil,
            limit: 1,
            sortDescriptors: [

                NSSortDescriptor(
                    key: HKSampleSortIdentifierEndDate,
                    ascending: false
                )
            ]
        ) { _, samples, error in

            guard error == nil else {
                return
            }

            guard let sample =
                samples?.first
                    as? HKQuantitySample
            else {
                return
            }

            let unit =
                HKUnit.count()
                    .unitDivided(
                        by: HKUnit.minute()
                    )

            let bpm =
                sample.quantity.doubleValue(
                    for: unit
                )

            DispatchQueue.main.async {

                self.latestHeartRate = bpm

                completion(bpm)
            }
        }

        healthStore.execute(query)
    }

    // MARK: - Sleep Detection

    func checkSleepState() {

        guard CMMotionActivityManager
            .isActivityAvailable()
        else {

            sleepText =
                "Motion unavailable"

            return
        }

        let now = Date()

        let startDate =
            Calendar.current.date(
                byAdding: .minute,
                value: -1,
                to: now
            )!

        motionManager.queryActivityStarting(
            from: startDate,
            to: now,
            to: .main
        ) { activities, error in

            if let error = error {

                self.sleepText =
                    error.localizedDescription

                return
            }

            guard let activity =
                activities?.last
            else {

                self.sleepText =
                    "No motion data"

                return
            }

            // MARK: - Movement Check

            let noMovement =
                activity.stationary

            if noMovement {

                self.lowMovementCount += 1

            } else {

                self.lowMovementCount = 0
            }
            
//            self.fetchRestingBPM { restingHeartRate in
//                
//                
//            }

            // MARK: - Fetch Heart Rate

            self.fetchHeartRate { bpm in

                let sleeping =
                    self.lowMovementCount >= 30 &&
                    self.isSleepTime() &&
                bpm <= (70 * 0.85)

                if sleeping {

                    self.sleepText =
                    """
                    User Probably Sleeping

                    HR: \(Int(bpm)) = \(55)
                    Still Count:
                    \(self.lowMovementCount) = \(self.lowMovementCount >= 30)
                    """
                    
                    self.modelContext?.insert(Book(title: "Sleeping", cover: "dune", audio: "By The Sea", author: "BPM : \(Int(bpm))", narrator: "movement:\(self.lowMovementCount)", synopsis: "sleepTime : \(Date.now)", duration: 20.0, status: "undone"))

                    AudioPlayerManager
                        .shared
                        .stopBecauseUserFellAsleep()

                    self.stopMonitoring()

                } else {
                    if let pickedBook = self.pickedBook {
                        NotificationManager.shared.scheduleSleepNotification(book: pickedBook)
                    } else {
                        NotificationManager.shared.scheduleSleepNotification(book: Book(
                            title: "Beauty and the Monster",
                            cover: "BookCover-TheBeautyAndTheMonster",
                            audio: "Beauty and the Monster",
                            author: "Stéphanie-Félicité de Genlis",
                            narrator: "Mary Kay",
                            synopsis: "A French theatrical adaptation of the famous fairy tale, The Beauty and the Monster is a drama of three characters - Beauty (Sabina), the Beast (Phanor) and Beauty's best friend, Phedima (the third wheel). - Summary by Mary Kay",
                            duration: 491,
                            status:"ongoing",
                            bookmark: 200,
                        ))
                    }
                    

                    self.sleepText =
                    """
                    User Awake

                    HR: \(Int(bpm)) = \(bpm <= (70 * 0.85))
                    Still Count:
                    \(self.lowMovementCount) = \(self.lowMovementCount >= 30)

                    SleepTime:
                    \(self.formattedSleepTime) = \(self.isSleepTime())
                    """
                }
            }
        }
    }

    // MARK: - Latest Sleep Stage

    func fetchLatestSleepStage() {

        guard let sleepType =
            HKObjectType.categoryType(
                forIdentifier: .sleepAnalysis
            )
        else {
            return
        }

        let sortDescriptor =
            NSSortDescriptor(
                key: HKSampleSortIdentifierEndDate,
                ascending: false
            )

        let query = HKSampleQuery(
            sampleType: sleepType,
            predicate: nil,
            limit: 1,
            sortDescriptors: [
                sortDescriptor
            ]
        ) { _, samples, error in

            DispatchQueue.main.async {

                if let error = error {

                    self.sleepText =
                        error.localizedDescription

                    return
                }

                guard let sample =
                    samples?.first
                        as? HKCategorySample
                else {

                    self.sleepText =
                        "No sleep data"

                    return
                }

                let value =
                    HKCategoryValueSleepAnalysis(
                        rawValue: sample.value
                    )

                switch value {

                case .awake:
                    self.sleepText = "Awake"

                case .asleep:
                    self.sleepText = "Asleep"

                case .asleepCore:
                    self.sleepText =
                        "Core Sleep"

                case .asleepDeep:
                    self.sleepText =
                        "Deep Sleep"

                case .asleepREM:
                    self.sleepText =
                        "REM Sleep"

                case .inBed:
                    self.sleepText =
                        "In Bed"

                default:
                    self.sleepText =
                        "Unknown"
                }
            }
        }

        healthStore.execute(query)
    }
}

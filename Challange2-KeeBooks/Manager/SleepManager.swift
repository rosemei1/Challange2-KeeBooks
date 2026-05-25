import Foundation
import HealthKit
import CoreMotion
import SwiftUI
import Combine

@MainActor
final class SleepManager: ObservableObject {

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

    // MARK: - Night Time Check

    private func isNightTime() -> Bool {

        let hour =
            Calendar.current.component(
                .hour,
                from: Date()
            )

        return hour >= 22 || hour <= 6
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

            // MARK: - Fetch Heart Rate

            self.fetchHeartRate { bpm in

                let sleeping =
                    self.lowMovementCount >= 30 &&
                    self.isNightTime() &&
                bpm <= (70 * 0.15)

                if sleeping {

                    self.sleepText =
                    """
                    User Probably Sleeping

                    HR: \(Int(bpm))
                    Still Count:
                    \(self.lowMovementCount)
                    """

                    AudioPlayerManager
                        .shared
                        .stopBecauseUserFellAsleep()

                    self.stopMonitoring()

                } else {

                    self.sleepText =
                    """
                    User Awake

                    HR: \(Int(bpm))
                    Still Count:
                    \(self.lowMovementCount)

                    Night:
                    \(self.isNightTime())
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

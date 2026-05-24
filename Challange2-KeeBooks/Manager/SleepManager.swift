import Foundation
import HealthKit
import Combine

@MainActor
final class SleepManager:
    ObservableObject {

    static let shared = SleepManager()

    private let healthStore = HKHealthStore()

    private var monitoringTimer: Timer?

    // MARK: - Request Permission

    func requestAuthorization() async {

        guard HKHealthStore
            .isHealthDataAvailable()
        else {
            return
        }

        guard let sleepType =
            HKObjectType.categoryType(
                forIdentifier: .sleepAnalysis
            )
        else {
            return
        }

        do {

            try await healthStore
                .requestAuthorization(
                    toShare: [],
                    read: [sleepType]
                )

        } catch {

            print(error.localizedDescription)
        }
    }

    // MARK: - Start Monitoring

    func startMonitoringSleep() {

        monitoringTimer?.invalidate()

        monitoringTimer = Timer.scheduledTimer(
            withTimeInterval: 60,
            repeats: true
        ) { _ in

            Task {

                let sleeping =
                    await self.isUserSleeping()

                if sleeping {

                    AudioPlayerManager
                        .shared
                        .stopBecauseUserFellAsleep()
                }
            }
        }
    }

    // MARK: - Stop Monitoring

    func stopMonitoringSleep() {

        monitoringTimer?.invalidate()

        monitoringTimer = nil
    }

    // MARK: - Sleep Check

    func isUserSleeping() async -> Bool {

        guard let sleepType =
            HKObjectType.categoryType(
                forIdentifier: .sleepAnalysis
            )
        else {

            return false
        }

        return await withCheckedContinuation {
            continuation in

            let startDate =
                Calendar.current.date(
                    byAdding: .hour,
                    value: -12,
                    to: Date()
                ) ?? Date()

            let predicate =
                HKQuery.predicateForSamples(
                    withStart: startDate,
                    end: Date()
                )

            let query = HKSampleQuery(
                sampleType: sleepType,
                predicate: predicate,
                limit: 1,
                sortDescriptors: [
                    NSSortDescriptor(
                        key: HKSampleSortIdentifierEndDate,
                        ascending: false
                    )
                ]
            ) { _, samples, _ in

                guard let sample =
                    samples?.first
                        as? HKCategorySample
                else {

                    continuation.resume(
                        returning: false
                    )

                    return
                }

                let value =
                    HKCategoryValueSleepAnalysis(
                        rawValue: sample.value
                    )

                switch value {

                case .asleep,
                     .asleepCore,
                     .asleepREM,
                     .asleepDeep:

                    continuation.resume(
                        returning: true
                    )

                default:

                    continuation.resume(
                        returning: false
                    )
                }
            }

            healthStore.execute(query)
        }
    }
}

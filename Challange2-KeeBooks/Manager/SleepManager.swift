import Foundation
import HealthKit
import Combine

@MainActor
final class SleepManager:
    ObservableObject {
    static let shared = SleepManager()
    
    // MARK: - HealthKit
    
    private let healthStore = HKHealthStore()
    
    // MARK: - Timers
    
    private var monitoringTimer: Timer?
    
    private var bedtimeTimer: Timer?
    
    // MARK: - User Sleep Time
    
    // Temporary variable
    // Example:
    // 11:00 PM bedtime
    var targetSleepTime: Date?
    
    // MARK: - Notification Control
    
    private var didSendNotificationToday = false
    
    private var lastNotificationDate: Date?
    
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
    
    // MARK: - Start Monitoring Sleep
    
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
    
    // MARK: - Stop Monitoring Sleep
    
    func stopMonitoringSleep() {
        
        monitoringTimer?.invalidate()
        
        monitoringTimer = nil
    }
    
    // MARK: - Start Bedtime Monitoring
    
    func startBedtimeMonitoring() {
        
        bedtimeTimer?.invalidate()
        
        bedtimeTimer = Timer.scheduledTimer(
            withTimeInterval: 60,
            repeats: true
        ) { _ in
            
            Task {
                
                await self.checkBedtime()
            }
        }
    }
    
    // MARK: - Stop Bedtime Monitoring
    
    func stopBedtimeMonitoring() {
        
        bedtimeTimer?.invalidate()
        
        bedtimeTimer = nil
    }
    
    // MARK: - Bedtime Check
    
    private func checkBedtime() async {
        
        guard let targetSleepTime else {
            return
        }
        
        resetNotificationFlagIfNeeded()
        
        // Prevent duplicates
        guard !didSendNotificationToday else {
            return
        }
        
        let calendar = Calendar.current
        
        let now = Date()
        
        let nowHour =
        calendar.component(
            .hour,
            from: now
        )
        
        let nowMinute =
        calendar.component(
            .minute,
            from: now
        )
        
        let targetHour =
        calendar.component(
            .hour,
            from: targetSleepTime
        )
        
        let targetMinute =
        calendar.component(
            .minute,
            from: targetSleepTime
        )
        
        // Match bedtime
        guard nowHour == targetHour,
              nowMinute == targetMinute
        else {
            return
        }
        
        let sleeping =
        await isUserSleeping()
        
        // User still awake
        if !sleeping {
            
            if let book =
                AudioPlayerManager
                .shared
                .currentBook {
                
                NotificationManager
                    .shared
                    .scheduleSleepNotification(
                        book: book
                    )
                
                didSendNotificationToday = true
                
                lastNotificationDate = Date()
            }
        }
    }
    
    // MARK: - Reset Notification State
    
    private func resetNotificationFlagIfNeeded() {
        
        guard let lastNotificationDate else {
            
            didSendNotificationToday = false
            
            return
        }
        
        if !Calendar.current
            .isDateInToday(lastNotificationDate) {
            
            didSendNotificationToday = false
        }
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
            ) { _, samples, error in
                
                if let error {
                    
                    print(error.localizedDescription)
                    
                    continuation.resume(
                        returning: false
                    )
                    
                    return
                }
                
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
                
                // Check valid sleep states
                let isAsleep: Bool
                
                switch value {
                    
                case .asleep,
                        .asleepCore,
                        .asleepREM,
                        .asleepDeep:
                    
                    isAsleep = true
                    
                default:
                    
                    isAsleep = false
                }
                
                // Ensure current time is inside sleep interval
                let now = Date()
                
                let isCurrentSleepSession =
                sample.startDate <= now &&
                sample.endDate >= now
                
                // Extra protection against stale data
                let isRecent =
                sample.endDate >
                now.addingTimeInterval(-900)
                
                let finalResult =
                isAsleep &&
                isCurrentSleepSession &&
                isRecent
                
                continuation.resume(
                    returning: finalResult
                )
            }
            
            healthStore.execute(query)
        }
    }
    
}

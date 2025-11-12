//
//  SportType.swift
//  WorkoutKitSync
//
//  Created on Clean Architecture Domain Layer
//

#if canImport(HealthKit) && (os(iOS) || os(watchOS))
import Foundation
import HealthKit

/// Domain representation of sport types
@available(iOS 18.0, watchOS 11.0, *)
public enum SportType: String, CaseIterable {
    case strengthTraining = "strengthTraining"
    case running = "running"
    case cycling = "cycling"
    case swimming = "swimming"
    case other = "other"
    
    /// Maps domain sport type to the closest HealthKit workout activity type
    @available(iOS 18.0, watchOS 11.0, *)
    public func toHealthKitActivityType() -> HKWorkoutActivityType {
        switch self {
        case .strengthTraining:
            return .traditionalStrengthTraining
        case .running:
            return .running
        case .cycling:
            return .cycling
        case .swimming:
            return .swimming
        case .other:
            return .other
        }
    }
}
#else
@available(*, unavailable, message: "WorkoutKitSync requires the WorkoutKit framework (iOS 18+/watchOS 11+).")
public enum SportType: String, CaseIterable {
    case strengthTraining = "strengthTraining"
    case running = "running"
    case cycling = "cycling"
    case swimming = "swimming"
    case other = "other"
}
#endif

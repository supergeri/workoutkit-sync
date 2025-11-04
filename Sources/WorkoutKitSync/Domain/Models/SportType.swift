//
//  SportType.swift
//  WorkoutKitSync
//
//  Created on Clean Architecture Domain Layer
//

import Foundation
import WorkoutKit

/// Domain representation of sport types
public enum SportType: String, CaseIterable {
    case strengthTraining = "strengthTraining"
    case running = "running"
    case cycling = "cycling"
    case swimming = "swimming"
    case other = "other"
    
    /// Maps domain sport type to WorkoutKit sport type
    public func toWorkoutKit() -> WKSportType {
        switch self {
        case .strengthTraining:
            return .strengthTraining
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

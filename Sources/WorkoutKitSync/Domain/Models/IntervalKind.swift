//
//  IntervalKind.swift
//  WorkoutKitSync
//
//  Created on Clean Architecture Domain Layer
//

import Foundation

/// Domain representation of interval kinds from JSON
public enum IntervalKind: String, Decodable {
    case repeatSet = "repeat"
    case reps = "reps"
    case distance = "distance"
    case time = "time"
    case warmup = "warmup"
    case cooldown = "cooldown"
}

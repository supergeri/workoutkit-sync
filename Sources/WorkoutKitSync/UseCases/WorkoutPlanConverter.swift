//
//  WorkoutPlanConverter.swift
//  WorkoutKitSync
//
//  Use Case: Converts DTO to WorkoutKit models
//

import Foundation
import WorkoutKit

/// Protocol for converting DTO to WorkoutKit models
public protocol WorkoutPlanConverterProtocol {
    func convert(_ dto: WKPlanDTO) throws -> WKWorkoutPlan
    func buildIntervals(from intervals: [WKPlanDTO.Interval]) throws -> [WKWorkoutPlanInterval]
    func mapSportType(_ sportType: String) -> WKSportType
}

/// Implementation of WorkoutPlanConverter
public struct WorkoutPlanConverter: WorkoutPlanConverterProtocol {
    
    public init() {}
    
    /// Converts a DTO to a WKWorkoutPlan
    public func convert(_ dto: WKPlanDTO) throws -> WKWorkoutPlan {
        let plan = WKWorkoutPlan(
            title: dto.title,
            sportType: mapSportType(dto.sportType)
        )
        
        plan.intervals = try buildIntervals(from: dto.intervals)
        
        return plan
    }
    
    /// Maps string sport type to WKSportType
    public func mapSportType(_ sportType: String) -> WKSportType {
        guard let domainType = SportType(rawValue: sportType) else {
            return .other
        }
        return domainType.toWorkoutKit()
    }
    
    /// Builds WorkoutKit intervals from DTO intervals
    public func buildIntervals(from intervals: [WKPlanDTO.Interval]) throws -> [WKWorkoutPlanInterval] {
        return try intervals.flatMap { interval in
            try buildIntervals(from: interval)
        }
    }
    
    /// Builds WorkoutKit intervals from a single DTO interval
    private func buildIntervals(from interval: WKPlanDTO.Interval) throws -> [WKWorkoutPlanInterval] {
        switch interval {
        case .warmup(let seconds, let target):
            let wkInterval = WKWorkoutPlanInterval(kind: .warmup)
            wkInterval.duration = WKWorkoutPlanIntervalDuration(timeInterval: TimeInterval(seconds))
            if let target = target {
                applyTarget(target, to: wkInterval)
            }
            return [wkInterval]
            
        case .cooldown(let seconds, let target):
            let wkInterval = WKWorkoutPlanInterval(kind: .cooldown)
            wkInterval.duration = WKWorkoutPlanIntervalDuration(timeInterval: TimeInterval(seconds))
            if let target = target {
                applyTarget(target, to: wkInterval)
            }
            return [wkInterval]
            
        case .repeatSet(let reps, let steps):
            // Build intervals from steps
            let stepIntervals = try steps.flatMap { step in
                try buildIntervals(from: step)
            }
            
            // Create repeat set
            let repeatInterval = WKWorkoutPlanInterval(kind: .repeat)
            repeatInterval.repeatCount = reps
            repeatInterval.intervals = stepIntervals
            
            return [repeatInterval]
            
        case .step(let step):
            return try buildIntervals(from: step)
        }
    }
    
    /// Builds WorkoutKit intervals from a step
    private func buildIntervals(from step: WKPlanDTO.Interval.Step) throws -> [WKWorkoutPlanInterval] {
        let kind = IntervalKind(rawValue: step.kind) ?? .time
        
        let interval = WKWorkoutPlanInterval(kind: mapStepKind(kind))
        
        // Set duration based on step type
        if let seconds = step.seconds {
            interval.duration = WKWorkoutPlanIntervalDuration(timeInterval: TimeInterval(seconds))
        } else if let meters = step.meters {
            interval.duration = WKWorkoutPlanIntervalDuration(distance: meters)
        }
        
        // Set reps if available
        if let reps = step.reps {
            interval.repeatCount = reps
        }
        
        // Set name if available
        if let name = step.name {
            interval.name = name
        }
        
        // Set rest if available
        if let restSec = step.restSec {
            interval.rest = WKWorkoutPlanIntervalRest(timeInterval: TimeInterval(restSec))
        }
        
        // Set target if available
        if let target = step.target {
            applyTarget(target, to: interval)
        }
        
        // Set load if available
        if let load = step.load {
            // Note: WorkoutKit load handling may vary - adjust based on API
            // This is a placeholder for load configuration
            interval.name = step.name ?? ""
        }
        
        return [interval]
    }
    
    /// Maps domain interval kind to WorkoutKit interval kind
    private func mapStepKind(_ kind: IntervalKind) -> WKWorkoutPlanIntervalKind {
        switch kind {
        case .time:
            return .work
        case .distance:
            return .work
        case .reps:
            return .work
        case .warmup:
            return .warmup
        case .cooldown:
            return .cooldown
        case .repeatSet:
            return .repeat
        }
    }
    
    /// Applies target information to a WorkoutKit interval
    private func applyTarget(_ target: WKPlanDTO.Interval.Target, to interval: WKWorkoutPlanInterval) {
        // Apply heart rate zone if available
        if let hrZone = target.hrZone {
            // Note: Adjust based on actual WorkoutKit API for heart rate zones
            // This may require creating a WKWorkoutPlanIntervalTarget or similar
        }
        
        // Apply pace if available
        if let pace = target.pace {
            // Note: Adjust based on actual WorkoutKit API for pace targets
            // This may require creating a WKWorkoutPlanIntervalTarget or similar
        }
    }
}

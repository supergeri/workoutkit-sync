//
//  WorkoutKitSync.swift
//  WorkoutKitSync
//
//  Main public API for WorkoutKitSync
//

import Foundation
import WorkoutKit

/// Main entry point for WorkoutKitSync functionality.
///
/// This struct provides a clean, easy-to-use API for converting JSON workout plans
/// into Apple WorkoutKit `WKWorkoutPlan` objects and saving them.
///
/// ## Usage
///
/// ```swift
/// let jsonString = "{ \"title\": \"My Workout\", ... }"
/// try await WorkoutKitSync.default.parseAndSave(from: jsonString)
/// ```
///
/// ## Architecture
///
/// WorkoutKitSync uses clean architecture principles:
/// - **Domain Layer**: Core business models
/// - **Data Layer**: JSON parsing and DTOs
/// - **Use Case Layer**: Business logic for conversion
/// - **Service Layer**: Orchestration of operations
public struct WorkoutKitSync {
    
    /// Default service instance for convenient usage
    public static let `default` = WorkoutKitSync()
    
    private let service: WorkoutPlanServiceProtocol
    
    /// Initialize with a custom service (useful for testing or custom configurations)
    /// - Parameter service: The service to use for operations
    public init(service: WorkoutPlanServiceProtocol = WorkoutPlanService()) {
        self.service = service
    }
    
    /// Saves a workout plan DTO to WorkoutKit
    /// - Parameter dto: The workout plan DTO to save
    /// - Throws: `WorkoutPlanError` if the save operation fails
    public func save(_ dto: WKPlanDTO) async throws {
        try await service.save(dto)
    }
    
    /// Parses JSON data into a workout plan DTO
    /// - Parameter jsonData: The JSON data to parse
    /// - Returns: A parsed `WKPlanDTO`
    /// - Throws: `WorkoutPlanError` if parsing fails
    public func parse(from jsonData: Data) throws -> WKPlanDTO {
        return try service.parse(from: jsonData)
    }
    
    /// Parses JSON string into a workout plan DTO
    /// - Parameter jsonString: The JSON string to parse
    /// - Returns: A parsed `WKPlanDTO`
    /// - Throws: `WorkoutPlanError` if parsing fails
    public func parse(from jsonString: String) throws -> WKPlanDTO {
        return try service.parse(from: jsonString)
    }
    
    /// Convenience method: Parse JSON and save to WorkoutKit in one call
    /// - Parameter jsonData: The JSON data to parse and save
    /// - Throws: `WorkoutPlanError` if parsing or saving fails
    public func parseAndSave(from jsonData: Data) async throws {
        let dto = try parse(from: jsonData)
        try await save(dto)
    }
    
    /// Convenience method: Parse JSON string and save to WorkoutKit in one call
    /// - Parameter jsonString: The JSON string to parse and save
    /// - Throws: `WorkoutPlanError` if parsing or saving fails
    public func parseAndSave(from jsonString: String) async throws {
        let dto = try parse(from: jsonString)
        try await save(dto)
    }
}

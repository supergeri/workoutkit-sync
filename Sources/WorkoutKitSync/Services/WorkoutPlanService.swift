//
//  WorkoutPlanService.swift
//  WorkoutKitSync
//
//  Service layer for orchestrating workout plan operations
//

import Foundation
import WorkoutKit

/// Protocol for workout plan service operations
public protocol WorkoutPlanServiceProtocol {
    func save(_ dto: WKPlanDTO) async throws
    func parse(from jsonData: Data) throws -> WKPlanDTO
    func parse(from jsonString: String) throws -> WKPlanDTO
}

/// Service for managing workout plan operations
public struct WorkoutPlanService: WorkoutPlanServiceProtocol {
    
    private let converter: WorkoutPlanConverterProtocol
    private let store: WKWorkoutPlanStore
    
    /// Initialize with custom converter and store
    public init(
        converter: WorkoutPlanConverterProtocol = WorkoutPlanConverter(),
        store: WKWorkoutPlanStore = .default
    ) {
        self.converter = converter
        self.store = store
    }
    
    /// Saves a workout plan DTO to WorkoutKit
    public func save(_ dto: WKPlanDTO) async throws {
        let plan = try converter.convert(dto)
        try await store.save(plan)
    }
    
    /// Parses JSON data into a DTO
    public func parse(from jsonData: Data) throws -> WKPlanDTO {
        let decoder = JSONDecoder()
        return try decoder.decode(WKPlanDTO.self, from: jsonData)
    }
    
    /// Parses JSON string into a DTO
    public func parse(from jsonString: String) throws -> WKPlanDTO {
        guard let data = jsonString.data(using: .utf8) else {
            throw WorkoutPlanError.invalidJSONString
        }
        return try parse(from: data)
    }
}

/// Errors that can occur during workout plan operations
public enum WorkoutPlanError: Error, LocalizedError {
    case invalidJSONString
    case parsingFailed(Error)
    case conversionFailed(Error)
    case saveFailed(Error)
    
    public var errorDescription: String? {
        switch self {
        case .invalidJSONString:
            return "Invalid JSON string format"
        case .parsingFailed(let error):
            return "Failed to parse JSON: \(error.localizedDescription)"
        case .conversionFailed(let error):
            return "Failed to convert DTO: \(error.localizedDescription)"
        case .saveFailed(let error):
            return "Failed to save workout plan: \(error.localizedDescription)"
        }
    }
}

//
//  ExampleUsage.swift
//  WorkoutKitSync Examples
//
//  This file demonstrates how to use WorkoutKitSync
//

import Foundation
import WorkoutKitSync

// MARK: - Example JSON
let exampleJSON = """
{
  "title": "Imported Workout",
  "sportType": "strengthTraining",
  "intervals": [
    {
      "kind": "repeat",
      "reps": 3,
      "intervals": [
        {
          "kind": "reps",
          "reps": 10,
          "name": "Bar Good Morning",
          "load": null,
          "restSec": null
        },
        {
          "kind": "reps",
          "reps": 12,
          "name": "Plank",
          "load": null,
          "restSec": null
        },
        {
          "kind": "distance",
          "meters": 20,
          "target": null
        }
      ]
    },
    {
      "kind": "repeat",
      "reps": 4,
      "intervals": [
        {
          "kind": "reps",
          "reps": 5,
          "name": "Dumbbell Front Squat",
          "load": null,
          "restSec": null
        },
        {
          "kind": "reps",
          "reps": 4,
          "name": "Burpee",
          "load": null,
          "restSec": null
        },
        {
          "kind": "reps",
          "reps": 10,
          "name": "Single Arm Kettlebell Swing",
          "load": null,
          "restSec": null
        }
      ]
    },
    {
      "kind": "repeat",
      "reps": 3,
      "intervals": [
        {
          "kind": "distance",
          "meters": 60,
          "target": null
        },
        {
          "kind": "reps",
          "reps": 25,
          "name": "Dumbbell Push Press",
          "load": null,
          "restSec": null
        },
        {
          "kind": "time",
          "seconds": 45,
          "target": null
        },
        {
          "kind": "distance",
          "meters": 27,
          "target": null
        },
        {
          "kind": "reps",
          "reps": 8,
          "name": "Hand Release Push Up",
          "load": null,
          "restSec": null
        }
      ]
    },
    {
      "kind": "repeat",
      "reps": 3,
      "intervals": [
        {
          "kind": "time",
          "seconds": 60,
          "target": null
        },
        {
          "kind": "time",
          "seconds": 90,
          "target": null
        }
      ]
    }
  ],
  "schedule": null
}
"""

// MARK: - Example 1: Simple Parse and Save
func example1SimpleUsage() async {
    do {
        try await WorkoutKitSync.default.parseAndSave(from: exampleJSON)
        print("✅ Workout plan saved successfully!")
    } catch {
        print("❌ Error: \(error.localizedDescription)")
    }
}

// MARK: - Example 2: Step-by-Step Parsing
func example2StepByStep() async {
    do {
        // Step 1: Parse JSON
        let dto = try WorkoutKitSync.default.parse(from: exampleJSON)
        print("✅ Parsed workout plan: \(dto.title)")
        print("   Sport type: \(dto.sportType)")
        print("   Number of intervals: \(dto.intervals.count)")
        
        // Step 2: Save to WorkoutKit
        try await WorkoutKitSync.default.save(dto)
        print("✅ Saved to WorkoutKit")
    } catch {
        print("❌ Error: \(error.localizedDescription)")
    }
}

// MARK: - Example 3: Parse from Data
func example3ParseFromData() async {
    guard let jsonData = exampleJSON.data(using: .utf8) else {
        print("❌ Failed to convert string to data")
        return
    }
    
    do {
        try await WorkoutKitSync.default.parseAndSave(from: jsonData)
        print("✅ Workout plan saved from data!")
    } catch {
        print("❌ Error: \(error.localizedDescription)")
    }
}

// MARK: - Example 4: Custom Service Configuration
func example4CustomService() async {
    // Create custom converter
    let converter = WorkoutPlanConverter()
    
    // Create custom service
    let service = WorkoutPlanService(converter: converter)
    
    // Create sync instance with custom service
    let sync = WorkoutKitSync(service: service)
    
    do {
        try await sync.parseAndSave(from: exampleJSON)
        print("✅ Saved with custom service!")
    } catch {
        print("❌ Error: \(error.localizedDescription)")
    }
}

// MARK: - Example 5: Error Handling
func example5ErrorHandling() async {
    let invalidJSON = "{ invalid json }"
    
    do {
        try await WorkoutKitSync.default.parseAndSave(from: invalidJSON)
    } catch WorkoutPlanError.invalidJSONString {
        print("❌ Invalid JSON string format")
    } catch WorkoutPlanError.parsingFailed(let error) {
        print("❌ Parsing failed: \(error.localizedDescription)")
    } catch WorkoutPlanError.conversionFailed(let error) {
        print("❌ Conversion failed: \(error.localizedDescription)")
    } catch WorkoutPlanError.saveFailed(let error) {
        print("❌ Save failed: \(error.localizedDescription)")
    } catch {
        print("❌ Unknown error: \(error.localizedDescription)")
    }
}

// MARK: - Example 6: Inspect DTO Structure
func example6InspectDTO() {
    do {
        let dto = try WorkoutKitSync.default.parse(from: exampleJSON)
        
        print("📋 Workout Plan Details:")
        print("   Title: \(dto.title)")
        print("   Sport Type: \(dto.sportType)")
        
        for (index, interval) in dto.intervals.enumerated() {
            print("\n   Interval \(index + 1):")
            switch interval {
            case .warmup(let seconds, let target):
                print("     Type: Warmup")
                print("     Duration: \(seconds) seconds")
                if let target = target {
                    print("     Target: HR Zone \(target.hrZone ?? 0), Pace \(target.pace ?? 0)")
                }
                
            case .cooldown(let seconds, let target):
                print("     Type: Cooldown")
                print("     Duration: \(seconds) seconds")
                if let target = target {
                    print("     Target: HR Zone \(target.hrZone ?? 0), Pace \(target.pace ?? 0)")
                }
                
            case .repeatSet(let reps, let steps):
                print("     Type: Repeat Set")
                print("     Repetitions: \(reps)")
                print("     Steps: \(steps.count)")
                for (stepIndex, step) in steps.enumerated() {
                    print("       Step \(stepIndex + 1): \(step.kind)")
                    if let name = step.name {
                        print("         Name: \(name)")
                    }
                    if let reps = step.reps {
                        print("         Reps: \(reps)")
                    }
                    if let seconds = step.seconds {
                        print("         Duration: \(seconds) seconds")
                    }
                    if let meters = step.meters {
                        print("         Distance: \(meters) meters")
                    }
                }
                
            case .step(let step):
                print("     Type: Step")
                print("     Kind: \(step.kind)")
                if let name = step.name {
                    print("     Name: \(name)")
                }
            }
        }
    } catch {
        print("❌ Error inspecting DTO: \(error.localizedDescription)")
    }
}

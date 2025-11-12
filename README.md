# WorkoutKit Sync

A clean architecture Swift package for converting JSON workout plans into Apple WorkoutKit `WorkoutPlan` objects.

## Architecture

This project follows clean architecture principles with clear separation of concerns:

- **Domain Layer**: Core domain models (`SportType`, `IntervalKind`)
- **Data Layer**: DTOs and JSON parsing (`WKPlanDTO`)
- **Use Case Layer**: Business logic for converting DTOs to WorkoutKit models (`WorkoutPlanConverter`)
- **Service Layer**: Orchestration of operations (`WorkoutPlanService`)
- **Application Layer**: Public API (`WorkoutKitSync`)

## Features

- ✅ Parse JSON workout plans into structured DTOs
- ✅ Convert DTOs to Apple WorkoutKit `WorkoutPlan` objects
- ✅ Support for complex interval structures (warmup, cooldown, repeat sets, steps)
- ✅ Support for multiple step types (time, distance, reps)
- ✅ Clean, testable architecture with protocol-based design
- ✅ Fully scalable and maintainable codebase

## Installation

### Swift Package Manager

Add this package to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/your-org/workoutkit-sync.git", from: "1.0.0")
]
```

Or add it via Xcode: File → Add Package Dependencies...

## Usage

### Basic Usage

```swift
import WorkoutKitSync

// Parse JSON and save to WorkoutKit
let jsonString = """
{
  "title": "Imported Workout",
  "sportType": "strengthTraining",
  "intervals": [...]
}
"""

do {
    try await WorkoutKitSync.default.parseAndSave(from: jsonString)
    print("Workout plan saved successfully!")
} catch {
    print("Error: \(error.localizedDescription)")
}
```

### Advanced Usage

```swift
import WorkoutKitSync

// Step 1: Parse JSON into DTO
let jsonData = // ... your JSON data
let dto = try WorkoutKitSync.default.parse(from: jsonData)

// Step 2: Save to WorkoutKit
try await WorkoutKitSync.default.save(dto, scheduleAt: nil)
```

### Custom Service Configuration

```swift
import WorkoutKitSync

// Create custom converter if needed
let converter = WorkoutPlanConverter()
let service = WorkoutPlanService(converter: converter)
let sync = WorkoutKitSync(service: service)

// Use the custom instance
try await sync.parseAndSave(from: jsonString, scheduleAt: nil)
```

## JSON Format

The library expects JSON in the following format:

```json
{
  "title": "Workout Title",
  "sportType": "strengthTraining",
  "schedule": {
    "startLocal": "2024-01-01T10:00:00"
  },
  "intervals": [
    {
      "kind": "repeat",
      "reps": 3,
      "intervals": [
        {
          "kind": "reps",
          "reps": 10,
          "name": "Exercise Name",
          "load": {
            "value": 50.0,
            "unit": "kg"
          },
          "restSec": 60,
          "target": {
            "hrZone": 3,
            "pace": 5.0
          }
        }
      ]
    }
  ]
}
```

### Supported Interval Kinds

- `"repeat"` - Repeat set with nested intervals
- `"reps"` - Repetition-based exercise
- `"distance"` - Distance-based interval
- `"time"` - Time-based interval
- `"warmup"` - Warmup interval
- `"cooldown"` - Cooldown interval

### Supported Sport Types

- `"strengthTraining"`
- `"running"`
- `"cycling"`
- `"swimming"`
- `"other"`

## Architecture Details

### Domain Layer

Core domain models that are independent of external frameworks:

- `SportType`: Enum representing sport types
- `IntervalKind`: Enum representing interval kinds

### Data Layer

- `WKPlanDTO`: Data Transfer Object for JSON parsing
  - Handles complex nested structures
  - Custom decoding for polymorphic intervals

### Use Case Layer

- `WorkoutPlanConverter`: Converts DTOs to WorkoutKit models
  - Protocol-based for testability
  - Handles all interval type conversions

### Service Layer

- `WorkoutPlanService`: Orchestrates parsing and saving
  - Injectable dependencies
  - Error handling

### Application Layer

- `WorkoutKitSync`: Public API for easy usage
  - Convenience methods
  - Default configurations

## Testing on Device

### Quick Setup

To test this on your iPhone or Apple Watch:

1. **Create Xcode Project**
   - File → New → Project → iOS App (or watchOS App)
   - Minimum iOS 17.0 / watchOS 10.0

2. **Add Local Package**
   - Package Dependencies → Add Local
   - Navigate to this package directory

3. **Add HealthKit Capability**
   - Signing & Capabilities → + Capability → HealthKit

4. **Add Source Files**
   - Use sample apps from `TestApp/` directory
   - See `TestApp/SETUP_INSTRUCTIONS.md` for detailed steps

5. **Run on Device**
   - Connect device → Select in Xcode → Run (Cmd+R)

📖 **Detailed instructions**: See `TestApp/SETUP_INSTRUCTIONS.md`  
🚀 **Quick start**: See `TestApp/QUICK_START.md`

### Unit Testing

The architecture is designed for easy testing:

```swift
// Mock converter for testing
class MockConverter: WorkoutPlanConverterProtocol {
    func convert(_ dto: WKPlanDTO) throws -> WorkoutPlan {
        // Test implementation
    }
    // ... other methods
}

// Use in tests
let service = WorkoutPlanService(converter: MockConverter())
```

## Requirements

- iOS 17.0+ / macOS 14.0+ / watchOS 10.0+
- Swift 5.9+
- Xcode 15.0+

## License

[Add your license here]

## Contributing

[Add contributing guidelines here]

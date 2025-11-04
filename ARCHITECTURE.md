# Architecture Overview

This document describes the clean architecture structure of the WorkoutKitSync project.

## Project Structure

```
WorkoutKitSync/
├── Sources/
│   └── WorkoutKitSync/
│       ├── Domain/                    # Domain Layer - Core Business Models
│       │   └── Models/
│       │       ├── SportType.swift    # Domain sport type enum
│       │       └── IntervalKind.swift # Domain interval kind enum
│       │
│       ├── Data/                      # Data Layer - JSON Parsing & DTOs
│       │   └── DTOs/
│       │       └── WKPlanDTO.swift    # Data Transfer Object for JSON
│       │
│       ├── UseCases/                  # Use Case Layer - Business Logic
│       │   └── WorkoutPlanConverter.swift  # Converts DTO to WorkoutKit
│       │
│       ├── Services/                  # Service Layer - Orchestration
│       │   └── WorkoutPlanService.swift    # Service for operations
│       │
│       └── WorkoutKitSync.swift       # Application Layer - Public API
│
├── Examples/
│   └── ExampleUsage.swift            # Usage examples
│
├── Package.swift                      # Swift Package Manager manifest
├── README.md                         # Project documentation
└── ARCHITECTURE.md                   # This file
```

## Layer Responsibilities

### 1. Domain Layer (`Domain/`)
**Purpose**: Core business models independent of external frameworks

- **SportType**: Enum representing sport types
- **IntervalKind**: Enum representing interval kinds

**Dependencies**: None (pure Swift)

### 2. Data Layer (`Data/`)
**Purpose**: Handle JSON parsing and data transfer

- **WKPlanDTO**: Data Transfer Object that mirrors the JSON structure
  - Custom `Decodable` implementation for polymorphic intervals
  - Handles nested structures (repeat sets, steps, etc.)

**Dependencies**: 
- Domain Layer (uses `IntervalKind`)

### 3. Use Case Layer (`UseCases/`)
**Purpose**: Business logic for converting DTOs to WorkoutKit models

- **WorkoutPlanConverter**: 
  - Converts `WKPlanDTO` to `WKWorkoutPlan`
  - Maps domain models to WorkoutKit types
  - Handles complex interval structures

**Dependencies**:
- Domain Layer
- Data Layer
- WorkoutKit framework

### 4. Service Layer (`Services/`)
**Purpose**: Orchestrate operations and handle errors

- **WorkoutPlanService**: 
  - Coordinates parsing and saving
  - Error handling and transformation
  - Injectable dependencies for testing

**Dependencies**:
- Use Case Layer
- WorkoutKit framework

### 5. Application Layer (`WorkoutKitSync.swift`)
**Purpose**: Public-facing API for easy usage

- **WorkoutKitSync**: 
  - Simple, convenient API
  - Default configurations
  - Convenience methods

**Dependencies**:
- Service Layer

## Dependency Flow

```
Application Layer (WorkoutKitSync)
    ↓
Service Layer (WorkoutPlanService)
    ↓
Use Case Layer (WorkoutPlanConverter)
    ↓
Data Layer (WKPlanDTO) ← → Domain Layer (SportType, IntervalKind)
    ↓
WorkoutKit Framework
```

**Key Principle**: Dependencies flow inward. Outer layers depend on inner layers, but inner layers never depend on outer layers.

## Design Patterns

### 1. Protocol-Oriented Programming
- `WorkoutPlanConverterProtocol`: Allows for easy mocking and testing
- `WorkoutPlanServiceProtocol`: Enables dependency injection

### 2. Dependency Injection
- Services accept protocols as dependencies
- Makes testing easier and code more flexible

### 3. Error Handling
- Custom `WorkoutPlanError` enum
- Proper error propagation through layers

### 4. Separation of Concerns
- Each layer has a single, well-defined responsibility
- Changes in one layer don't affect others

## Scalability & Maintainability

### Adding New Features

1. **New Sport Type**: 
   - Add to `SportType` enum (Domain)
   - Add mapping in `SportType.toWorkoutKit()` (Domain)
   - No changes needed in other layers

2. **New Interval Type**:
   - Add to `IntervalKind` enum (Domain)
   - Update `WKPlanDTO.Interval` decoding (Data)
   - Update `WorkoutPlanConverter` mapping (Use Case)

3. **New JSON Field**:
   - Add to `WKPlanDTO` (Data)
   - Update converter if needed (Use Case)

### Testing Strategy

Each layer can be tested independently:

- **Domain Layer**: Pure Swift, easy to test
- **Data Layer**: Test JSON parsing with sample data
- **Use Case Layer**: Mock DTOs and test conversion logic
- **Service Layer**: Mock converter and test orchestration
- **Application Layer**: Integration tests

### Benefits

1. **Testability**: Each layer can be tested in isolation
2. **Maintainability**: Clear boundaries make changes easier
3. **Scalability**: Easy to add new features without breaking existing code
4. **Flexibility**: Can swap implementations (e.g., different converters)
5. **Clarity**: Each file has a clear, single purpose

## Future Enhancements

The architecture supports easy addition of:

- Caching layer
- Network layer for remote JSON
- Multiple output formats
- Validation layer
- Analytics/monitoring layer
- Local storage layer

Each can be added without affecting existing layers.

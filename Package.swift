// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "WorkoutKitSync",
    platforms: [
        .iOS(.v18),
        .watchOS(.v11)
    ],
    products: [
        .library(
            name: "WorkoutKitSync",
            targets: ["WorkoutKitSync"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WorkoutKitSync",
            dependencies: []
        ),
        .testTarget(
            name: "WorkoutKitSyncTests",
            dependencies: ["WorkoutKitSync"],
            path: "Tests/WorkoutKitSyncTests"
        ),
    ]
)

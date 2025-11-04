// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "WorkoutKitSync",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .watchOS(.v10)
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
            dependencies: ["WorkoutKitSync"]
        ),
    ]
)

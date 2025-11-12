# Xcode Troubleshooting Guide for `WorkoutKitSyncTest`

This document captures the recurring Xcode issues we hit while getting the sample app (`WorkoutKitSyncTest`) to build and run, along with the proven fixes.

## 1. “Multiple commands produce …/Info.plist”
- **Symptom**: Build fails because Xcode tries to copy `Info.plist` twice.
- **Cause**: `Info.plist` is both referenced via the `INFOPLIST_FILE` build setting and added to *Copy Bundle Resources*.
- **Fix**:
  1. In Xcode, select the `WorkoutKitSyncTest` target → *Build Settings* → search `Info.plist File`.
  2. Set the value to `/Users/davidandrews/dev/workoutkit-sync/TestApp/WorkoutKitSyncTest/Info.plist` for all configurations.
  3. Open *Build Phases* → *Copy Bundle Resources* and remove any `Info.plist` entry.
  4. Clean build folder (`Shift+Cmd+K`) and rebuild.

## 2. “Cannot code sign because the target does not have an Info.plist file”
- **Symptom**: Build stops before code signing.
- **Cause**: `INFOPLIST_FILE` points at a stale path (often `…/dev/IOS/…`).
- **Fix**:
  1. Update the `Info.plist File` build setting to `/Users/davidandrews/dev/workoutkit-sync/TestApp/WorkoutKitSyncTest/Info.plist`.
  2. Ensure *File Inspector → Target Membership* is unchecked for `Info.plist` (the build setting is sufficient).
  3. Delete DerivedData for the target:  
     `rm -rf ~/Library/Developer/Xcode/DerivedData/WorkoutKitSyncTest-*`
  4. Clean and rebuild.

## 3. “Failed to install … Missing bundle ID”
- **Symptom**: App builds but won’t install on device or simulator.
- **Cause**: The packaged bundle lacks a `CFBundleIdentifier` because Xcode still packaged the wrong `Info.plist`.
- **Fix**:
  1. Perform the `Info.plist` steps above.
  2. Verify that `TestApp/WorkoutKitSyncTest/Info.plist` contains `CFBundleIdentifier`, `CFBundleExecutable`, and other required keys.
  3. Clean DerivedData and rebuild.

## 4. “Cannot find type ‘WK…’ in scope” / modern WorkoutKit APIs missing
- **Symptom**: Swift errors referencing placeholder `WK…` types.
- **Cause**: `WorkoutKit` framework only exists in iOS 18 / watchOS 11 SDKs (Xcode 16+), and the code used old placeholder names.
- **Fix**:
  1. Install Xcode 16 or newer and set *Xcode → Settings → Locations → Command Line Tools* to Xcode 16.
  2. Update `Package.swift` platforms to `iOS(.v18)`/`watchOS(.v11)` and `swift-tools-version: 6.0`.
  3. Refactor code to use real `WorkoutKit` types (`WorkoutPlan`, `CustomWorkout`, `WorkoutScheduler`, etc.).
  4. Wrap WorkoutKit-dependent sources in `#if canImport(WorkoutKit) && (os(iOS) || os(watchOS))` with fallbacks.

## 5. Concurrency warnings about `Sendable`
- **Symptom**: Build warnings/errors: “Type is not Sendable” or “capture of ‘self’ with main-actor-isolated property”.
- **Fix**:
  1. Add `@MainActor` to `WorkoutPlanServiceProtocol`, `WorkoutPlanService`, and `WorkoutKitSync`.
  2. Ensure DTOs conform to `Sendable`.
  3. Use `@preconcurrency import WorkoutKit` where needed, and mark `WorkoutScheduler.AuthorizationState` as `@unchecked Sendable`.

## 6. Need to reset Swift Package caches
- **Symptom**: Build still references old binaries after manifest changes.
- **Fix**: In Xcode, choose *File → Packages → Reset Package Caches* and then *Resolve Package Versions*. Follow up with a clean build.

## 7. Simulator/device not appearing as a destination
- **Symptom**: No iOS 18 simulator or physical device listed.
- **Fix**:
  1. Install the iOS 18 simulator runtime via *Xcode → Settings → Platforms*.
  2. For a physical device, ensure it’s on iOS 18+ with developer mode enabled and trust the Mac.
  3. If the device still doesn’t appear, restart both device and Xcode.

## 8. Runtime crash on import: “unsupportedGoal(WorkoutGoal.distance…)”
- **Symptom**: Tapping “Import Workout” crashes with `unsupportedGoal`.
- **Cause**: Strength-training workouts were emitting distance goals, which `WorkoutKit` rejects for that activity.
- **Fix**:
  1. Update `SportType` with a `supportsDistanceGoals` property.
  2. Change `WorkoutPlanConverter` to only emit `.distance` goals for running/cycling/swimming, and use `.open` for other sports.
  3. Add unit tests to cover the fallback.

## 9. General cleanup steps after any fix
- Product → *Clean Build Folder…*
- Delete DerivedData for the project.
- Reset package caches if SPM artifacts are stale.
- Rebuild and, if targeting devices, reselect the destination before running.

Keep this guide handy—anytime Xcode reports one of these errors, apply the matching fix and rebuild. Feel free to append new sections as other issues surface.


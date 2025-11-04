# Setup Instructions for Testing on iPhone/Apple Watch

Follow these steps to test WorkoutKitSync on your device:

## Prerequisites

- Xcode 15.0 or later
- iOS 17.0+ device (iPhone) or watchOS 10.0+ device (Apple Watch)
- Apple Developer account (free account works for device testing)
- Device connected to your Mac

## Option 1: Create Xcode Project Manually (Recommended)

### Step 1: Create New Project

1. Open Xcode
2. File → New → Project
3. Select **iOS** → **App**
4. Click **Next**
5. Fill in:
   - Product Name: `WorkoutKitSyncTest`
   - Team: Select your Apple Developer team
   - Organization Identifier: `com.yourname` (or your domain)
   - Interface: **SwiftUI**
   - Language: **Swift**
   - Minimum Deployment: **iOS 17.0**
6. Click **Next**
7. Choose a location (can be outside the package directory)
8. Click **Create**

### Step 2: Add Local Package Dependency

1. In Xcode, select your project in the navigator
2. Select the project target (`WorkoutKitSyncTest`)
3. Go to the **Package Dependencies** tab
4. Click the **+** button
5. Click **Add Local...**
6. Navigate to `/Users/davidandrews/dev/workoutkit-sync`
7. Click **Add Package**
8. Make sure `WorkoutKitSync` is checked under "Add to Target"
9. Click **Add Package**

### Step 3: Add HealthKit Capability

1. Select your project in the navigator
2. Select the `WorkoutKitSyncTest` target
3. Go to the **Signing & Capabilities** tab
4. Click **+ Capability**
5. Add **HealthKit**
6. Enable both:
   - ✅ HealthKit
   - ✅ Workout Routing (if available)

### Step 4: Add Source Files

1. Delete the default `ContentView.swift` and `WorkoutKitSyncTestApp.swift` from Xcode
2. Right-click on your project in the navigator
3. Select **Add Files to "WorkoutKitSyncTest"...**
4. Navigate to `/Users/davidandrews/dev/workoutkit-sync/TestApp/WorkoutKitSyncTest/`
5. Select both Swift files:
   - `ContentView.swift`
   - `WorkoutKitSyncTestApp.swift`
6. Make sure **Copy items if needed** is **unchecked**
7. Click **Add**

### Step 5: Add Info.plist Entries

1. Open your project's `Info.plist` (or create one if it doesn't exist)
2. Add these keys:
   - `NSHealthShareUsageDescription`: "This app needs access to read workout data to sync workout plans."
   - `NSHealthUpdateUsageDescription`: "This app needs access to save workout plans to your Health app."

Or add the provided `Info.plist` file from the TestApp directory.

### Step 6: Configure Signing

1. Select your project
2. Select the `WorkoutKitSyncTest` target
3. Go to **Signing & Capabilities**
4. Select your **Team**
5. Xcode will automatically create a provisioning profile

### Step 7: Connect Device and Run

1. Connect your iPhone to your Mac via USB
2. Trust the computer on your iPhone if prompted
3. In Xcode, select your device from the device menu (top toolbar)
4. Click the **Run** button (▶️) or press `Cmd+R`
5. If prompted, trust the developer certificate on your iPhone:
   - Settings → General → VPN & Device Management
   - Trust your developer certificate

## Option 2: Create watchOS App (Optional)

### Step 1: Add watchOS Target

1. In your existing Xcode project
2. File → New → Target
3. Select **watchOS** → **App**
4. Click **Next**
5. Fill in:
   - Product Name: `WorkoutKitSyncWatch`
   - Bundle Identifier: `com.yourname.WorkoutKitSyncTest.WorkoutKitSyncWatch`
6. Click **Finish**

### Step 2: Add Package Dependency to watchOS Target

1. Select the `WorkoutKitSyncWatch` target
2. Go to **Package Dependencies** tab
3. The local package should already be available
4. Make sure `WorkoutKitSync` is checked for the watchOS target

### Step 3: Add HealthKit Capability (watchOS)

1. Select `WorkoutKitSyncWatch` target
2. Go to **Signing & Capabilities**
3. Add **HealthKit** capability

### Step 4: Add Source Files

1. Add the watchOS source files from `/Users/davidandrews/dev/workoutkit-sync/TestApp/WorkoutKitSyncWatch/`

### Step 5: Run on Apple Watch

1. Connect your Apple Watch (paired with iPhone)
2. Select the watchOS target and device
3. Click **Run**

## Testing

### iOS App

1. Launch the app on your iPhone
2. The default JSON workout plan will be loaded
3. Tap **"Import Workout"**
4. If successful, you'll see: "✅ Workout plan imported successfully!"
5. Open the **Fitness** app on your iPhone
6. Go to **Workouts** → **Plans**
7. You should see your imported workout plan

### watchOS App

1. Launch the app on your Apple Watch
2. Tap **"Import Workout"**
3. Check the Fitness app on your iPhone or Apple Watch

## Troubleshooting

### "Missing required capability"
- Make sure HealthKit capability is added
- Clean build folder (Cmd+Shift+K) and rebuild

### "Code signing error"
- Check your Apple Developer account is signed in
- Verify your Team is selected in Signing & Capabilities

### "WorkoutKit not available"
- Ensure you're targeting iOS 17.0+ or watchOS 10.0+
- WorkoutKit requires these minimum versions

### "Failed to save workout plan"
- Check HealthKit permissions in Settings → Privacy & Security → Health
- Ensure the app has permission to write workout data

### Package not found
- Make sure the local package path is correct
- Try removing and re-adding the package dependency
- Clean build folder (Cmd+Shift+K)

## Quick Test Script

You can also create a simple Swift script to test:

```swift
import WorkoutKitSync

let json = """
{
  "title": "Test Workout",
  "sportType": "strengthTraining",
  "intervals": [...]
}
"""

Task {
    do {
        try await WorkoutKitSync.default.parseAndSave(from: json)
        print("Success!")
    } catch {
        print("Error: \(error)")
    }
}
```

## Notes

- WorkoutKit requires iOS 17.0+ and watchOS 10.0+
- You need an Apple Developer account (free tier works)
- Device must be connected and trusted
- HealthKit permissions must be granted

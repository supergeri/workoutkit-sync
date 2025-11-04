# Quick Start Guide - Testing on Device

## 🚀 Install Prerequisites (Optional)

You can check and install dependencies from the command line:

```bash
cd TestApp

# Check what's installed
./install_dependencies.sh

# Install all optional dependencies (XcodeGen)
./install_all.sh
```

**Note**: XcodeGen is optional - you can set up the project manually in Xcode.

## Fastest Way to Test

### 1. Open Xcode
```bash
open -a Xcode
```

### 2. Create New Project
- **File** → **New** → **Project**
- Select **iOS** → **App**
- Name: `WorkoutKitSyncTest`
- Interface: **SwiftUI**
- Language: **Swift**
- Minimum: **iOS 17.0**

### 3. Add Local Package
- Select project → **Package Dependencies** tab
- Click **+** → **Add Local...**
- Navigate to: `/Users/davidandrews/dev/workoutkit-sync`
- Click **Add Package**
- Check `WorkoutKitSync` → **Add Package**

### 4. Add HealthKit
- Select target → **Signing & Capabilities**
- Click **+ Capability** → **HealthKit**
- Enable both checkboxes

### 5. Replace Default Files
- Delete `ContentView.swift` and `*App.swift`
- Right-click project → **Add Files...**
- Navigate to: `TestApp/WorkoutKitSyncTest/`
- Select both `.swift` files
- **Uncheck** "Copy items if needed"
- Click **Add**

### 6. Add Info.plist
- Add the `Info.plist` from `TestApp/` directory
- Or manually add HealthKit usage descriptions

### 7. Configure Signing
- Select your **Team** in Signing & Capabilities
- Xcode will auto-generate provisioning profile

### 8. Run on Device
- Connect iPhone via USB
- Select device from device menu
- Press **Cmd+R** to run
- Trust developer certificate on device if prompted

## Verify It Works

1. **Launch app** on iPhone
2. **Tap "Import Workout"** button
3. **See success message**: "✅ Workout plan imported successfully!"
4. **Open Fitness app** → **Workouts** → **Plans**
5. **Find your workout** in the list

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Package not found | Check path is correct, remove and re-add |
| HealthKit error | Add HealthKit capability, check Info.plist |
| Code signing | Select your Team in Signing & Capabilities |
| Build fails | Clean build folder (Cmd+Shift+K) |
| Workout not appearing | Check Health permissions in Settings |

## For Apple Watch

Same steps, but:
- Create **watchOS** target instead of iOS
- Use files from `TestApp/WorkoutKitSyncWatch/`
- Deploy to Apple Watch (paired with iPhone)

## Quick Test Code

You can also test directly in a Swift playground or script:

```swift
import WorkoutKitSync

let json = """
{
  "title": "Test",
  "sportType": "strengthTraining",
  "intervals": [
    {"kind": "reps", "reps": 10, "name": "Push Ups"}
  ]
}
"""

Task {
    try? await WorkoutKitSync.default.parseAndSave(from: json)
}
```

That's it! 🎉

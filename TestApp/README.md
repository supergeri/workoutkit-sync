# Test App for WorkoutKitSync

This directory contains sample iOS and watchOS apps to test WorkoutKitSync on your devices.

## 🚀 Quick Installation Check

Run this to check what's installed:

```bash
cd TestApp
./install_dependencies.sh
```

To install optional dependencies (XcodeGen for automated project generation):

```bash
./install_all.sh
```

## 📁 Directory Structure

```
TestApp/
├── WorkoutKitSyncTest/          # iOS app source files
│   ├── ContentView.swift        # Main UI with JSON editor
│   └── WorkoutKitSyncTestApp.swift
│
├── WorkoutKitSyncWatch/          # watchOS app source files
│   ├── ContentView.swift        # Simplified watch UI
│   └── WorkoutKitSyncWatchApp.swift
│
├── Info.plist                   # HealthKit permissions
├── SETUP_INSTRUCTIONS.md        # Detailed setup guide
├── QUICK_START.md              # Quick reference
├── install_dependencies.sh     # Check prerequisites
├── install_all.sh              # Install optional deps
└── create_xcode_project.sh     # Helper script (optional)
```

## 🚀 Quick Start

### For iPhone Testing

1. **Check prerequisites**:
   ```bash
   cd TestApp
   ./install_dependencies.sh
   ```

2. **Open Xcode** → Create new iOS App project
3. **Add Local Package**: 
   - Package Dependencies → Add Local
   - Path: `/Users/davidandrews/dev/workoutkit-sync`
4. **Add HealthKit Capability**
5. **Add Source Files** from `WorkoutKitSyncTest/`
6. **Run on Device**

See `QUICK_START.md` for step-by-step instructions.

### For Apple Watch Testing

Same steps, but:
- Create watchOS target
- Use files from `WorkoutKitSyncWatch/`
- Deploy to paired Apple Watch

## 📱 What the Apps Do

### iOS App (`WorkoutKitSyncTest`)
- **JSON Editor**: Edit workout plan JSON directly
- **Import Button**: Tap to parse and save workout
- **Status Messages**: Shows success/error feedback
- **Full Workout Plan**: Includes all interval types

### watchOS App (`WorkoutKitSyncWatch`)
- **Simple Interface**: Optimized for watch screen
- **One-Tap Import**: Quick test with sample workout
- **Status Display**: Shows import result

## ✅ Verification

After importing:
1. Open **Fitness** app on iPhone
2. Go to **Workouts** → **Plans**
3. Find your imported workout plan

## 🔧 Troubleshooting

| Problem | Solution |
|---------|----------|
| Package not found | Verify local package path is correct |
| HealthKit error | Add HealthKit capability + Info.plist entries |
| Code signing | Select your Team in Signing & Capabilities |
| Build fails | Clean build folder (Cmd+Shift+K) |
| Workout not appearing | Check Health app permissions in Settings |

## 📖 Documentation

- **QUICK_START.md**: Fast setup guide
- **SETUP_INSTRUCTIONS.md**: Detailed step-by-step instructions
- **Main README.md**: Package documentation

## 🎯 Features Tested

- ✅ JSON parsing
- ✅ DTO conversion
- ✅ WorkoutKit integration
- ✅ HealthKit permissions
- ✅ Error handling
- ✅ Complex interval structures

## Next Steps

1. Run `./install_dependencies.sh` to check prerequisites
2. Follow `QUICK_START.md` to set up quickly
3. Or see `SETUP_INSTRUCTIONS.md` for detailed steps
4. Customize the JSON in the app to test different workouts
5. Verify workouts appear in Fitness app

Happy testing! 🎉
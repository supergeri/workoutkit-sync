# How to Test WorkoutKitSync

## Step-by-Step Testing Guide

### Step 1: Open Xcode
```bash
open -a Xcode
```

Or click the Xcode icon in your Applications folder.

---

### Step 2: Create New iOS Project

1. In Xcode: **File** → **New** → **Project**
2. Select **iOS** tab → **App**
3. Click **Next**
4. Fill in:
   - **Product Name**: `WorkoutKitSyncTest`
   - **Team**: Select your Apple ID (free account works)
   - **Organization Identifier**: `com.yourname` (or your domain)
   - **Interface**: **SwiftUI** ✓
   - **Language**: **Swift** ✓
   - **Minimum Deployment**: **iOS 17.0** ✓
5. Click **Next**
6. Choose a location (can be anywhere, like Desktop)
7. Click **Create**

---

### Step 3: Add the WorkoutKitSync Package

1. In Xcode, click on your **project name** (blue icon) in the left sidebar
2. Select the **WorkoutKitSyncTest** target
3. Click the **Package Dependencies** tab (at the top)
4. Click the **+** button (bottom left)
5. Click **Add Local...**
6. Navigate to: `/Users/davidandrews/dev/workoutkit-sync`
7. Click **Add Package**
8. Make sure **WorkoutKitSync** is checked under "Add to Target"
9. Click **Add Package**

✅ The package should now appear in your project navigator.

---

### Step 4: Add HealthKit Capability

1. Still in the project settings, click the **Signing & Capabilities** tab
2. Click **+ Capability** (top left)
3. Search for **HealthKit**
4. Double-click **HealthKit**
5. Make sure both checkboxes are enabled:
   - ✅ HealthKit
   - ✅ Workout Routing (if available)

---

### Step 5: Add the Test App Files

1. In the project navigator (left sidebar), find and **delete**:
   - `ContentView.swift`
   - `WorkoutKitSyncTestApp.swift`

2. Right-click on your project folder (WorkoutKitSyncTest)
3. Select **Add Files to "WorkoutKitSyncTest"...**
4. Navigate to: `/Users/davidandrews/dev/workoutkit-sync/TestApp/WorkoutKitSyncTest/`
5. Select **both** Swift files:
   - `ContentView.swift`
   - `WorkoutKitSyncTestApp.swift`
6. **IMPORTANT**: Uncheck **"Copy items if needed"** ✓
7. Make sure **"Add to targets: WorkoutKitSyncTest"** is checked
8. Click **Add**

---

### Step 6: Add HealthKit Permissions

1. In the project navigator, find `Info.plist` (or create one if it doesn't exist)
2. Right-click → **Open As** → **Source Code**
3. Add these keys inside the `<dict>` tag:

```xml
<key>NSHealthShareUsageDescription</key>
<string>This app needs access to read workout data to sync workout plans.</string>
<key>NSHealthUpdateUsageDescription</key>
<string>This app needs access to save workout plans to your Health app.</string>
```

Or simply drag the `Info.plist` file from `/Users/davidandrews/dev/workoutkit-sync/TestApp/` into your project.

---

### Step 7: Configure Code Signing

1. Still in **Signing & Capabilities** tab
2. Under **Signing**, select your **Team** (your Apple ID)
3. Xcode will automatically create a provisioning profile

If you get an error:
- Make sure you're signed into your Apple ID in Xcode
- Go to **Xcode** → **Settings** → **Accounts** to add your Apple ID

---

### Step 8: Connect Your iPhone

1. Connect your iPhone to your Mac via USB cable
2. Unlock your iPhone
3. Trust the computer if prompted on your iPhone
4. In Xcode, click the device selector (top toolbar, next to the play button)
5. Select your iPhone from the list

---

### Step 9: Run the App

1. Click the **Play** button (▶️) in Xcode
2. Or press **Cmd+R**

**First time on device:**
- Your iPhone will show a prompt
- Go to **Settings** → **General** → **VPN & Device Management**
- Tap your developer certificate
- Tap **Trust**

The app should build and launch on your iPhone!

---

### Step 10: Test the Import

1. **On your iPhone**, the app should open
2. You'll see a JSON editor with a workout plan already loaded
3. **Tap the "Import Workout"** button
4. Wait a moment...
5. You should see: **"✅ Workout plan imported successfully!"**

---

### Step 11: Verify in Fitness App

1. **On your iPhone**, open the **Fitness** app (or **Activity** app on older iOS)
2. Tap **Workouts** tab (bottom)
3. Tap **Plans** (if available) or look for your workout
4. You should see **"Imported Workout"** in the list!

---

## 🎉 Success!

If you see your workout in the Fitness app, it worked!

## ❌ Troubleshooting

### "Package not found"
- Make sure the path is exactly: `/Users/davidandrews/dev/workoutkit-sync`
- Try removing and re-adding the package

### "HealthKit not available"
- Make sure you added the HealthKit capability
- Check that Info.plist has the usage descriptions

### "Code signing error"
- Select your Team in Signing & Capabilities
- Make sure you're signed into Xcode with your Apple ID

### "Build failed"
- Clean build folder: **Product** → **Clean Build Folder** (Shift+Cmd+K)
- Try building again

### "Workout not appearing in Fitness app"
- Check Health permissions: **Settings** → **Privacy & Security** → **Health**
- Make sure the app has permission to write workouts
- Try importing again

### "App crashes"
- Check the Xcode console for error messages
- Make sure your iPhone is running iOS 17.0+

---

## Quick Visual Checklist

- [ ] Xcode project created
- [ ] Local package added
- [ ] HealthKit capability added
- [ ] Test files added (ContentView.swift, App.swift)
- [ ] Info.plist configured
- [ ] Team selected for signing
- [ ] iPhone connected
- [ ] App runs on device
- [ ] Import button works
- [ ] Workout appears in Fitness app

---

## Need Help?

- See `SETUP_INSTRUCTIONS.md` for more details
- See `QUICK_START.md` for a quick reference
- Check Xcode console for error messages

Happy testing! 🚀

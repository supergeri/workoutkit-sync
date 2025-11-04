# TestFlight Deployment Guide

## Why TestFlight?

- ✅ Install on any device (iPhone, iPad, Watch) without USB
- ✅ Easy updates - just re-upload new version
- ✅ Works wirelessly after initial setup
- ✅ No need to open Xcode every time
- ✅ Can share with others if needed

## Prerequisites

1. **Apple Developer Account** (free account works for TestFlight)
   - Sign up at: https://developer.apple.com
   - Free account allows TestFlight for up to 10 testers

2. **App Store Connect** access
   - Go to: https://appstoreconnect.apple.com
   - Sign in with your Apple ID

## Step 1: Create App in App Store Connect

1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Click **My Apps** → **+** → **New App**
3. Fill in:
   - **Platform**: iOS
   - **Name**: WorkoutKitSync (or your name)
   - **Primary Language**: English
   - **Bundle ID**: Create new (e.g., `com.yourname.workoutkitsync`)
   - **SKU**: Any unique identifier
4. Click **Create**

## Step 2: Build Your App in Xcode

1. Open your Xcode project (from HOW_TO_TEST.md setup)
2. In Xcode, select your target
3. **Signing & Capabilities**:
   - Select your **Team** (your Apple ID)
   - **Bundle Identifier**: Must match App Store Connect (e.g., `com.yourname.workoutkitsync`)
4. **Product** → **Archive**
5. Wait for archive to complete

## Step 3: Upload to App Store Connect

1. **Window** → **Organizer** (or Shift+Cmd+O)
2. Select your archive
3. Click **Distribute App**
4. Choose **App Store Connect**
5. Click **Next**
6. Choose **Upload**
7. Click **Next**
8. Select your distribution options
9. Click **Upload**
10. Wait for upload to complete

## Step 4: Add to TestFlight

1. Go back to [App Store Connect](https://appstoreconnect.apple.com)
2. Select your app
3. Click **TestFlight** tab
4. Wait for processing (can take 10-30 minutes)
5. Once processed, your build will appear

## Step 5: Install TestFlight App

1. On your iPhone, open **App Store**
2. Search for **TestFlight**
3. Install the **TestFlight** app (free, by Apple)

## Step 6: Add Yourself as Tester

1. In App Store Connect, go to **TestFlight** tab
2. Click **Internal Testing** (or **External Testing**)
3. Click **+** to add testers
4. Add your email address
5. Click **Add**

## Step 7: Install Your App

1. On your iPhone, open **TestFlight** app
2. You should see an invitation email, or
3. Tap **Accept** on the invitation
4. Your app will appear in TestFlight
5. Tap **Install**

## Step 8: Use Your App

1. Find your app on your iPhone home screen
2. Open it
3. Upload workouts as needed
4. No Xcode needed! 🎉

## Updating Your App

When you want to update:

1. Make changes in Xcode
2. **Product** → **Archive**
3. **Distribute App** → **App Store Connect** → **Upload**
4. Wait for processing in App Store Connect
5. TestFlight will notify you of update
6. Tap **Update** in TestFlight app

That's it! No USB cable needed after initial setup.

## Troubleshooting

### "No builds available"
- Wait for processing (can take 30+ minutes)
- Check that upload completed successfully

### "Invitation not received"
- Check spam folder
- Add yourself manually in TestFlight section

### "App won't install"
- Make sure TestFlight app is installed
- Check that you accepted the invitation
- Try deleting and reinstalling from TestFlight

## Benefits Summary

✅ **No Xcode needed** after initial setup  
✅ **No USB cable** needed  
✅ **Works on any device** you add  
✅ **Easy updates** - just re-upload  
✅ **Wireless installation**  

Perfect for regular use! 🚀

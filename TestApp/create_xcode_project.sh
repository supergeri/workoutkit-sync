#!/bin/bash

# Script to help create Xcode project for testing WorkoutKitSync
# This script provides instructions and creates necessary files

echo "🚀 WorkoutKitSync Test App Setup"
echo "================================"
echo ""
echo "This script will help you set up an Xcode project for testing."
echo ""
echo "PREREQUISITES:"
echo "  - Xcode 15.0+ installed"
echo "  - iOS 17.0+ device or watchOS 10.0+ device"
echo "  - Apple Developer account"
echo ""
echo "SETUP OPTIONS:"
echo "  1. Manual setup (recommended) - Follow SETUP_INSTRUCTIONS.md"
echo "  2. Use XcodeGen (if installed) - Automatically generates project"
echo ""
read -p "Choose option (1 or 2): " option

case $option in
    1)
        echo ""
        echo "📖 Please follow the instructions in SETUP_INSTRUCTIONS.md"
        echo ""
        echo "Quick steps:"
        echo "  1. Open Xcode"
        echo "  2. Create new iOS App project"
        echo "  3. Add local package: $(pwd)/.."
        echo "  4. Add HealthKit capability"
        echo "  5. Add source files from TestApp/WorkoutKitSyncTest/"
        echo "  6. Configure signing"
        echo "  7. Run on device"
        echo ""
        ;;
    2)
        if ! command -v xcodegen &> /dev/null; then
            echo "❌ XcodeGen not found. Install with: brew install xcodegen"
            exit 1
        fi
        
        echo "📦 Generating Xcode project with XcodeGen..."
        
        # Create project.yml for XcodeGen
        cat > project.yml << EOF
name: WorkoutKitSyncTest
options:
  bundleIdPrefix: com.workoutkit
  deploymentTarget:
    iOS: "17.0"
    watchOS: "10.0"
  
packages:
  WorkoutKitSync:
    path: ../

targets:
  WorkoutKitSyncTest:
    type: application
    platform: iOS
    sources:
      - path: WorkoutKitSyncTest
    dependencies:
      - package: WorkoutKitSync
    capabilities:
      - HealthKit
    info:
      path: Info.plist
      properties:
        NSHealthShareUsageDescription: "This app needs access to read workout data to sync workout plans."
        NSHealthUpdateUsageDescription: "This app needs access to save workout plans to your Health app."
  
  WorkoutKitSyncWatch:
    type: application
    platform: watchOS
    sources:
      - path: WorkoutKitSyncWatch
    dependencies:
      - package: WorkoutKitSync
    capabilities:
      - HealthKit
EOF

        xcodegen generate
        echo "✅ Project generated! Open WorkoutKitSyncTest.xcodeproj"
        ;;
    *)
        echo "Invalid option"
        exit 1
        ;;
esac

echo ""
echo "📱 Next Steps:"
echo "  1. Open the project in Xcode"
echo "  2. Select your development team in Signing & Capabilities"
echo "  3. Connect your device"
echo "  4. Run the app (Cmd+R)"
echo ""
echo "For detailed instructions, see SETUP_INSTRUCTIONS.md"

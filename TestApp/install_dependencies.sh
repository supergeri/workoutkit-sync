#!/bin/bash

# Installation script for WorkoutKitSync test app dependencies
# This checks and installs what's needed to test on your device

set -e

echo "🔍 Checking prerequisites for WorkoutKitSync testing..."
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check Xcode
echo "Checking Xcode..."
if command -v xcodebuild &> /dev/null; then
    XCODE_VERSION=$(xcodebuild -version 2>/dev/null | head -1)
    echo -e "${GREEN}✅ $XCODE_VERSION found${NC}"
    
    # Check if Xcode version is 15.0+
    XCODE_MAJOR=$(echo "$XCODE_VERSION" | grep -oE '[0-9]+' | head -1)
    if [ "$XCODE_MAJOR" -ge 15 ]; then
        echo -e "${GREEN}   Version 15.0+ ✓${NC}"
    else
        echo -e "${YELLOW}   ⚠️  Version should be 15.0 or higher${NC}"
    fi
else
    echo -e "${RED}❌ Xcode not found${NC}"
    echo "   Please install Xcode from the App Store"
    echo "   https://apps.apple.com/us/app/xcode/id497799835"
    exit 1
fi

# Check Xcode Command Line Tools
echo ""
echo "Checking Xcode Command Line Tools..."
if xcode-select -p &> /dev/null; then
    echo -e "${GREEN}✅ Xcode Command Line Tools installed${NC}"
else
    echo -e "${YELLOW}⚠️  Xcode Command Line Tools not found${NC}"
    echo "   Installing..."
    xcode-select --install || echo "   Please install manually from Xcode → Settings → Locations"
fi

# Check Homebrew (optional, for XcodeGen)
echo ""
echo "Checking Homebrew (optional)..."
if command -v brew &> /dev/null; then
    echo -e "${GREEN}✅ Homebrew installed${NC}"
    BREW_INSTALLED=true
else
    echo -e "${YELLOW}⚠️  Homebrew not installed (optional)${NC}"
    BREW_INSTALLED=false
fi

# Check XcodeGen (optional)
echo ""
echo "Checking XcodeGen (optional)..."
if command -v xcodegen &> /dev/null; then
    echo -e "${GREEN}✅ XcodeGen installed${NC}"
    XCODEGEN_INSTALLED=true
else
    echo -e "${YELLOW}⚠️  XcodeGen not installed (optional)${NC}"
    XCODEGEN_INSTALLED=false
    
    if [ "$BREW_INSTALLED" = true ]; then
        echo "   To install: brew install xcodegen"
    fi
fi

# Check if device is connected (optional)
echo ""
echo "Checking for connected iOS devices..."
DEVICES=$(xcrun xctrace list devices 2>/dev/null | grep -i "iphone\|ipad" | head -1 || echo "")
if [ -n "$DEVICES" ]; then
    echo -e "${GREEN}✅ Device detected:${NC}"
    echo "   $DEVICES"
else
    echo -e "${YELLOW}⚠️  No iOS device connected${NC}"
    echo "   Connect your iPhone/iPad via USB to test"
fi

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "${GREEN}✅ Prerequisites Check Complete${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📋 SUMMARY:"
echo "   ✅ Xcode: Ready"
echo "   ✅ Command Line Tools: Ready"
if [ "$XCODEGEN_INSTALLED" = true ]; then
    echo "   ✅ XcodeGen: Installed (optional)"
else
    echo "   ⚠️  XcodeGen: Not installed (not required)"
fi
echo ""
echo "🚀 NEXT STEPS:"
echo ""
echo "   1. Open Xcode:"
echo "      open -a Xcode"
echo ""
echo "   2. Create new iOS App project:"
echo "      File → New → Project → iOS → App"
echo ""
echo "   3. Add local package:"
echo "      Package Dependencies → + → Add Local"
echo "      Path: $(cd .. && pwd)"
echo ""
echo "   4. Follow the guide:"
echo "      cat QUICK_START.md"
echo ""
echo "   Or use the automated setup (if XcodeGen installed):"
if [ "$XCODEGEN_INSTALLED" = true ]; then
    echo "      ./create_xcode_project.sh"
else
    echo "      (XcodeGen not installed - use manual setup)"
fi
echo ""
echo "📖 For detailed instructions:"
echo "   cat SETUP_INSTRUCTIONS.md"
echo ""

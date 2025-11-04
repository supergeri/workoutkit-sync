#!/bin/bash

# Automated installation script - installs all optional dependencies

set -e

echo "🚀 Installing all optional dependencies..."
echo ""

# Check Homebrew
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install XcodeGen
if ! command -v xcodegen &> /dev/null; then
    echo "📦 Installing XcodeGen..."
    brew install xcodegen
    echo "✅ XcodeGen installed"
else
    echo "✅ XcodeGen already installed"
fi

echo ""
echo "✅ All dependencies installed!"
echo ""
echo "Next: Run ./install_dependencies.sh to verify everything"

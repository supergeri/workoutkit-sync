#!/bin/bash

# Script to push WorkoutKitSync to a new GitHub repository

set -e

echo "🚀 Push WorkoutKitSync to GitHub"
echo "=================================="
echo ""

# Check if remote already exists
if git remote get-url origin &> /dev/null; then
    echo "Remote 'origin' already exists:"
    git remote get-url origin
    read -p "Do you want to update it? (y/n): " update
    if [ "$update" != "y" ] && [ "$update" != "Y" ]; then
        echo "Cancelled."
        exit 0
    fi
fi

echo ""
echo "To push to GitHub, you have two options:"
echo ""
echo "Option 1: Create repository on GitHub first, then push"
echo "  - Go to https://github.com/new"
echo "  - Create a new repository (don't initialize with README)"
echo "  - Copy the repository URL"
echo ""
echo "Option 2: Use GitHub CLI (if installed)"
echo "  - Run: gh repo create"
echo ""

read -p "Do you want to use GitHub CLI (gh)? (y/n): " use_gh

if [ "$use_gh" = "y" ] || [ "$use_gh" = "Y" ]; then
    if command -v gh &> /dev/null; then
        echo ""
        echo "Creating repository with GitHub CLI..."
        gh repo create workoutkit-sync --public --source=. --remote=origin --push
        echo ""
        echo "✅ Repository created and pushed!"
    else
        echo "❌ GitHub CLI (gh) not installed."
        echo "Install with: brew install gh"
        echo ""
        echo "Falling back to manual setup..."
        use_gh="n"
    fi
fi

if [ "$use_gh" != "y" ] && [ "$use_gh" != "Y" ]; then
    echo ""
    read -p "Enter your GitHub repository URL (e.g., https://github.com/username/workoutkit-sync.git): " repo_url
    
    if [ -z "$repo_url" ]; then
        echo "❌ No URL provided. Exiting."
        exit 1
    fi
    
    # Remove existing origin if updating
    if git remote get-url origin &> /dev/null; then
        git remote remove origin
    fi
    
    # Add remote
    git remote add origin "$repo_url"
    echo "✅ Remote added: $repo_url"
    
    # Set default branch to main
    git branch -M main
    
    # Push
    echo ""
    echo "Pushing to GitHub..."
    git push -u origin main
    
    echo ""
    echo "✅ Successfully pushed to GitHub!"
    echo "Repository: $repo_url"
fi

echo ""
echo "📋 Next steps:"
echo "  1. Visit your repository on GitHub"
echo "  2. Add a description if needed"
echo "  3. Update README.md if needed"
echo "  4. Consider adding topics/tags"
echo ""

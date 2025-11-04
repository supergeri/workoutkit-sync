# Push to GitHub - Quick Instructions

## ✅ Repository Initialized

Your local repository is ready with the first commit!

## Push to GitHub

### Option 1: Using the Script (Easiest)

```bash
./push_to_github.sh
```

This will guide you through:
- Creating a GitHub repository (if you have GitHub CLI)
- Or connecting to an existing repository
- Pushing your code

### Option 2: Manual Push

#### Step 1: Create Repository on GitHub

1. Go to https://github.com/new
2. Repository name: `workoutkit-sync` (or your choice)
3. Description: "Clean architecture Swift package for converting JSON workout plans to Apple WorkoutKit"
4. Choose Public or Private
5. **Don't** initialize with README, .gitignore, or license (we already have these)
6. Click **Create repository**

#### Step 2: Add Remote and Push

```bash
# Add your GitHub repository as remote
git remote add origin https://github.com/YOUR_USERNAME/workoutkit-sync.git

# Replace YOUR_USERNAME with your GitHub username
# Or use SSH: git@github.com:YOUR_USERNAME/workoutkit-sync.git

# Push to GitHub
git push -u origin main
```

#### Step 3: Verify

Visit your repository on GitHub to see your code!

## Using GitHub CLI (Alternative)

If you have GitHub CLI installed:

```bash
# Install GitHub CLI (if needed)
brew install gh

# Login
gh auth login

# Create repository and push
gh repo create workoutkit-sync --public --source=. --remote=origin --push
```

## Current Status

```bash
# Check current status
git status

# View commit history
git log --oneline

# View remote (after adding)
git remote -v
```

## Next Steps After Push

1. **Add Topics** on GitHub: `swift`, `workoutkit`, `ios`, `swift-package`
2. **Update README** if needed (add badges, screenshots, etc.)
3. **Add License** if you want to open source it
4. **Create Releases** when you have stable versions

## Troubleshooting

### "Repository not found"
- Check the repository URL is correct
- Make sure you created the repository on GitHub first
- Verify you have access to the repository

### "Authentication failed"
- Use SSH instead of HTTPS: `git@github.com:username/repo.git`
- Or set up a Personal Access Token
- Or use GitHub CLI: `gh auth login`

### "Branch name mismatch"
- GitHub might use `master` instead of `main`
- Run: `git push -u origin main:master` (if needed)
- Or rename: `git branch -M main`

## Quick Commands

```bash
# Check if remote exists
git remote -v

# Add remote (if not exists)
git remote add origin https://github.com/USERNAME/REPO.git

# Push to GitHub
git push -u origin main

# Update remote URL (if needed)
git remote set-url origin https://github.com/USERNAME/REPO.git
```

That's it! 🚀

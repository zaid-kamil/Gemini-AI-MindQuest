# GitHub Pages Deployment Guide - Flutter Web

## Overview

This guide will help you deploy the Flutter Gemini AI MindQuest app to GitHub Pages using GitHub Actions.

## Prerequisites

- GitHub repository with the Flutter project
- Admin access to the repository settings

## Setup Steps

### 1. Enable GitHub Pages

1. Go to your repository on GitHub: `https://github.com/zaid-kamil/johnny_task`
2. Click on **Settings** tab
3. In the left sidebar, click on **Pages**
4. Under "Build and deployment":
   - **Source**: Select "GitHub Actions"
   - ✅ This enables GitHub Actions to deploy to Pages

### 2. GitHub Actions Workflow

The workflow file is already created at:
```
.github/workflows/flutter-pages.yml
```

**What it does:**
- ✅ Triggers on push to `main` branch
- ✅ Sets up Flutter environment (v3.24.0)
- ✅ Installs dependencies
- ✅ Builds Flutter web with correct base-href
- ✅ Deploys to GitHub Pages

### 3. Base HREF Configuration

The workflow builds with `--base-href "/johnny_task/"` because GitHub Pages serves repos at:
```
https://zaid-kamil.github.io/johnny_task/
```

**Important:** If you change the repository name, update the base-href in the workflow file.

### 4. Commit and Push

```bash
cd c:\Users\xaidm\Downloads\johnny_task
git add .github/workflows/flutter-pages.yml
git commit -m "Add GitHub Actions workflow for Flutter web deployment"
git push origin main
```

### 5. Monitor Deployment

1. Go to **Actions** tab in your GitHub repository
2. You'll see "Deploy Flutter Web to GitHub Pages" workflow running
3. Wait for it to complete (usually 2-3 minutes)
4. Once complete, your app will be live at:
   ```
   https://zaid-kamil.github.io/johnny_task/
   ```

## Workflow Details

### Build Job

```yaml
- Setup Flutter (v3.24.0 stable)
- Run: flutter pub get
- Run: flutter build web --release --base-href "/johnny_task/"
- Upload build artifacts
```

### Deploy Job

```yaml
- Deploy artifacts to GitHub Pages
- Uses GitHub's official deploy-pages action
```

## Permissions

The workflow requires these permissions (already configured):
- `contents: read` - Read repository content
- `pages: write` - Write to GitHub Pages
- `id-token: write` - Generate deployment token

## Troubleshooting

### Issue: Pages not enabled
**Solution**: 
1. Go to Settings → Pages
2. Set Source to "GitHub Actions"

### Issue: 404 error after deployment
**Solution**: 
- Check base-href matches repository name
- Wait a few minutes for DNS propagation
- Clear browser cache

### Issue: Workflow fails
**Solution**:
1. Check Actions tab for error logs
2. Ensure Flutter version is available
3. Check if all dependencies can be resolved

### Issue: Firebase not working
**Solution**:
Firebase is configured in the code. If you see connection errors:
1. Check browser console for errors
2. Verify Firebase project is active
3. Check Firebase SDK loads correctly

## Manual Deployment (Alternative)

If you prefer manual deployment:

```bash
# Build locally
cd flutter_gemini_ai_mind_quest
flutter build web --release --base-href "/johnny_task/"

# Deploy using GitHub CLI
cd build/web
gh-pages -d . -b gh-pages
```

Or use the Firebase hosting:
```bash
firebase deploy --only hosting
```

## Automatic Deployments

Every push to `main` branch will automatically:
1. Build the Flutter web app
2. Deploy to GitHub Pages
3. Update the live site

You can also trigger manual deployment:
1. Go to Actions tab
2. Select "Deploy Flutter Web to GitHub Pages"
3. Click "Run workflow"
4. Select branch and click "Run workflow"

## Custom Domain (Optional)

To use a custom domain:

1. Go to Settings → Pages
2. Under "Custom domain", enter your domain
3. Add these DNS records to your domain:
   ```
   Type: CNAME
   Name: www (or subdomain)
   Value: zaid-kamil.github.io
   ```
4. Wait for DNS propagation (up to 24 hours)
5. Enable "Enforce HTTPS"

## Environment URLs

| Environment | URL |
|-------------|-----|
| **Production** | https://zaid-kamil.github.io/johnny_task/ |
| **Local Dev** | http://localhost:8080 |
| **Flutter Run** | Varies (check terminal output) |

## Workflow Configuration

### Change Flutter Version

Edit `.github/workflows/flutter-pages.yml`:
```yaml
- name: Setup Flutter
  uses: subosito/flutter-action@v2
  with:
    flutter-version: '3.24.0'  # ← Change this
    channel: 'stable'
```

### Change Base HREF

If you rename the repository:
```yaml
- name: Build web
  working-directory: ./flutter_gemini_ai_mind_quest
  run: flutter build web --release --base-href "/new-repo-name/"
```

### Add Environment Variables

To add secrets (like API keys):
```yaml
- name: Build web
  working-directory: ./flutter_gemini_ai_mind_quest
  env:
    API_KEY: ${{ secrets.API_KEY }}
  run: flutter build web --release
```

Then add secrets in: Settings → Secrets and variables → Actions

## Build Optimization

The workflow includes:
- ✅ **Tree shaking**: Reduces bundle size
- ✅ **Minification**: Compresses JavaScript
- ✅ **Release mode**: Optimized performance
- ✅ **WebAssembly**: Supported (no dart:html)

## Monitoring

Check deployment status:
1. **Actions tab**: See build logs
2. **Deployments**: View deployment history
3. **Pages settings**: See current deployment URL

## Cost

GitHub Pages is **FREE** for public repositories:
- ✅ Unlimited bandwidth
- ✅ Unlimited builds
- ✅ Automatic SSL/HTTPS
- ✅ Global CDN

## Next Steps

After deployment:
1. ✅ Test the live site
2. ✅ Share the URL
3. ✅ Set up custom domain (optional)
4. ✅ Enable branch protection (optional)
5. ✅ Add status badge to README

## Status Badge

Add to your README.md:
```markdown
[![Deploy to GitHub Pages](https://github.com/zaid-kamil/johnny_task/actions/workflows/flutter-pages.yml/badge.svg)](https://github.com/zaid-kamil/johnny_task/actions/workflows/flutter-pages.yml)
```

---

## Summary

✅ **Workflow Created**: `.github/workflows/flutter-pages.yml`
✅ **Auto Deploy**: Pushes to main branch
✅ **Live URL**: https://zaid-kamil.github.io/johnny_task/
✅ **Zero Cost**: Free GitHub Pages hosting

**Ready to Deploy!** Just push to main branch and GitHub Actions will handle the rest. 🚀

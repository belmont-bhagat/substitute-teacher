# Repository Protection Setup Guide

## 🔒 How to Protect Your Repository

This guide explains how to set up complete protection for your repository to prevent unauthorized changes.

## 📋 Step-by-Step Protection Setup

### 1. Enable Branch Protection (Required)

1. Go to your GitHub repository: https://github.com/belmont-bhagat/substitute-teacher
2. Click on **Settings**
3. Navigate to **Branches** in the left sidebar
4. Click **Add rule** or edit the existing rule for `main` branch
5. Configure the following settings:

#### ✅ Required Settings:

- **☑️ Require pull request reviews before merging**
  - ☑️ Require approvals: `1` (at least your approval)
  - ☑️ Dismiss stale pull request approvals when new commits are pushed
  - ☑️ Require review from Code Owners

- **☑️ Require status checks to pass before merging**
  - Select: `protect-main`

- **☑️ Require branches to be up to date before merging**

- **☑️ Include administrators**
  - ✅ This ensures even you must follow the approval process

- **☑️ Do not allow bypassing the above settings**

- **☑️ Restrict who can push to matching branches**
  - Select only yourself

- **☑️ Restrict who can delete matching branches**
  - Select only yourself

- **☑️ Lock branch** (Optional but recommended)
  - Prevents anyone from pushing directly

#### ❌ Don't Allow:

- ❌ Allow force pushes
- ❌ Allow deletions
- ❌ Allow bypassing required status checks

### 2. Repository Settings

1. Go to **Settings** → **General**
2. Scroll to **Danger Zone**
3. **Do NOT** click "Change repository visibility"
4. Keep repository as **Private** or **Public** (your choice)

### 3. Collaborator Settings

1. Go to **Settings** → **Manage access**
2. Review all collaborators
3. **Remove** any collaborators who shouldn't have access
4. For new collaborators:
   - Use **Write** access at minimum
   - Required reviewers will still be enforced

### 4. Branch Protection Rules

Copy these exact settings to your `main` branch protection:

```
✅ Require pull request reviews before merging
   - Required approvals: 1
   - Dismiss stale pull request approvals when new commits are pushed
   - Require review from Code Owners

✅ Require status checks to pass before merging
   - Selected branch protection rule: protect-main

✅ Require conversation resolution before merging

✅ Require branches to be up to date before merging

✅ Require signed commits (Optional)

✅ Include administrators (VERY IMPORTANT)
   - Ensures even you must follow the process

✅ Do not allow bypassing the above settings

✅ Restrict who can push to matching branches
   - Select only yourself or a specific team

✅ Restrict who can delete matching branches
   - Select only yourself
```

### 5. CODEOWNERS File

Create a `.github/CODEOWNERS` file with:

```
# Default owners for everything in the repo
* @belmont-bhagat
```

This ensures all changes require your approval.

### 6. Disable Fork and Clone Restrictions (Optional)

If you want to allow contributions via forks:

1. **Settings** → **General**
2. Under **Features**:
   - ✅ Allow forking
   - ✅ Allow cloning
   - ⚠️ **Block pushes**: Enable to prevent direct pushes

### 7. GitHub Actions (Already Set Up)

The workflow file `.github/workflows/protect.yml` is already created and will:
- Run checks on all pull requests
- Verify branch protection
- Ensure all changes go through approval

## 🛡️ What This Protects Against

✅ **Unauthorized Changes**: No one can push directly to main  
✅ **Force Pushes**: Prevents rewriting history  
✅ **Branch Deletion**: Protects against accidental deletion  
✅ **Unreviewed Code**: All code requires your approval  
✅ **Bypass Attempts**: Even admins must follow the process  
✅ **Accidental Merges**: Requires explicit approval  

## ✅ Verification Checklist

- [ ] Branch protection enabled for `main`
- [ ] Require pull request reviews: 1 approval minimum
- [ ] Require status checks to pass
- [ ] Include administrators in protection
- [ ] Do not allow bypassing protection
- [ ] CODEOWNERS file created
- [ ] Collaborator list reviewed
- [ ] Protected branches configured
- [ Timesheet is locked (optional)

## 🚨 Important Notes

1. **You are the owner**: Only you can:
   - Merge pull requests
   - Approve changes
   - Modify protection settings
   - Delete protected branches

2. **Contributors can**:
   - Fork the repository
   - Create branches
   - Submit pull requests
   - NOT merge without your approval

3. **Emergency Access**: If you need to push directly (in emergencies):
   - Temporarily disable branch protection
   - Make your changes
   - Re-enable protection immediately

4. **Testing**: After setting up protection:
   - Try creating a test pull request
   - Verify it requires your approval
   - Test the merge process

## 📝 Current Protection Status

The following files are committed to enforce protection:

- ✅ `.github/workflows/protect.yml` - GitHub Actions workflow
- ✅ `CONTRIBUTING.md` - Contribution guidelines
- ⚠️ **Manual Setup Required**: Branch protection rules in GitHub Settings

## 🔗 Quick Links

- [Branch Protection Settings](https://github.com/belmont-bhagat/substitute-teacher/settings/branches)
- [Repository Settings](https://github.com/belmont-bhagat/substitute-teacher/settings)
- [Manage Access](https://github.com/belmont-bhagat/substitute-teacher/settings/access)
- [GitHub Branch Protection Docs](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches)

---

**Remember**: Complete the manual branch protection setup in GitHub Settings for full protection!

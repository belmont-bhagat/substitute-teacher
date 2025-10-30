# 🎨 Make This Project Your Own

**For Students: Customize this project with your own package name and private repository**

This guide will help you transform this template project into your own personalized version with your custom package structure and private GitHub repository.

> **Important**: This guide uses placeholders like `YOUR-INSTITUTION`, `YOUR-NAME`, and `YOUR-PROJECT-NAME`. You should replace these with your own choices throughout the process!

---

## 📝 Quick Planning Sheet

**Before you start, fill in YOUR choices here:**

```
┌─────────────────────────────────────────────────────────────┐
│  MY CUSTOMIZATION CHOICES                                   │
├─────────────────────────────────────────────────────────────┤
│                                                              │
│  Package Name:    _________________________________          │
│  Example: edu.belmont.pranish                                │
│                                                              │
│  Project Name:    _________________________________          │
│  Example: my-login-app                                       │
│                                                              │
│  Repository Name: _________________________________          │
│  Example: johns-auth-project                                 │
│                                                              │
│  Your Name:       _________________________________          │
│  Example: Pranish Bhagat                                     │
│                                                              │
│  Institution:     _________________________________          │
│  Example: Belmont University                                 │
│                                                              │
└─────────────────────────────────────────────────────────────┘

Keep this handy! You'll use these throughout the guide.
```

---

## 📚 What You'll Learn

- How to rename Java packages in a Spring Boot project
- How to update all configuration files
- How to create your own private GitHub repository
- Best practices for package naming

---

## 🎯 Step 1: Choose Your Customization Options

### A. Choose Your Package Name

**Current Package (Template):**
```
com.example.simpleloginbackend
```

**Your New Package - YOU DECIDE!**

Follow the reverse domain name convention:
```
edu.YOUR-INSTITUTION.YOUR-NAME
```

**Example Options** (Choose what fits you):

| Type | Pattern | Your Choice | Example |
|------|---------|-------------|---------|
| University | `edu.institution.yourname` | _____________ | `edu.belmont.pranish` |
| University | `edu.institution.lastname` | _____________ | `edu.vanderbilt.smith` |
| Personal | `com.yourname.projectname` | _____________ | `com.john.loginapp` |
| Organization | `org.groupname.projectname` | _____________ | `org.myteam.authservice` |

**Naming Rules:**
- ✅ All lowercase
- ✅ No spaces or special characters (except dots)
- ✅ Use reverse domain convention (edu/com/org first)
- ✅ Make it meaningful to you

**Write your choice here:**
```
MY PACKAGE NAME: _________________________________
```

---

### B. Choose Your Project Name

**Current Project Name:** `simple-login-backend`

**Your New Project Name - YOU DECIDE!**

This will be:
- Your Maven artifact ID
- Your repository name (if you choose)
- Your project folder name

**Example Options:**

| Type | Your Choice | Example |
|------|-------------|---------|
| Keep similar | _____________ | `my-login-app` |
| Descriptive | _____________ | `student-auth-system` |
| Personal | _____________ | `johns-auth-project` |
| Creative | _____________ | `secure-login-app` |

**Naming Rules:**
- ✅ All lowercase
- ✅ Use hyphens for spaces
- ✅ Keep it short and descriptive
- ✅ No special characters

**Write your choice here:**
```
MY PROJECT NAME: _________________________________
```

---

### C. Choose Your Repository Name

**Your Repository Name - YOU DECIDE!**

This can be:
- Same as your project name
- Something different
- Whatever makes sense to you

**Write your choice here:**
```
MY REPOSITORY NAME: _________________________________
```

---

## 🔧 Step 2: Rename the Package Structure

### Your Decisions Summary:

Before proceeding, confirm your choices:

```
✏️ Current Package:  com.example.simpleloginbackend
✏️ New Package:      _____________________________ (your choice from Step 1A)

✏️ Current Project:  simple-login-backend
✏️ New Project:      _____________________________ (your choice from Step 1B)

✏️ Repository Name:  _____________________________ (your choice from Step 1C)
```

**Important:** In the examples below, replace:
- `YOUR-PACKAGE` with your package name choice
- `YOUR-PROJECT` with your project name choice
- `YOUR-REPO` with your repository name choice

---

## 📝 Step 3: Make the Changes

### Method 1: Using Your IDE (Recommended - Easiest)

#### **IntelliJ IDEA / Cursor:**

1. **Open the project** in your IDE

2. **Navigate to the package**:
   ```
   simple-login-backend/src/main/java/com/example/simpleloginbackend/
   ```

3. **Right-click on `simpleloginbackend` folder** → **Refactor** → **Rename**

4. **Enable "Search in comments and strings"** and **"Search for text occurrences"**

5. **Enter YOUR chosen package name** (from Step 1A)
   
   Example: `edu.belmont.pranish` or `com.yourname.loginapp`

6. **Click "Refactor"** - Your IDE will automatically:
   - Rename all package declarations
   - Update all import statements
   - Move files to new directory structure
   - Update references in configuration files

7. **Verify the new structure** matches your choice:
   ```
   simple-login-backend/src/main/java/YOUR-PACKAGE-PATH/
   ```
   
   For example:
   - If you chose `edu.belmont.pranish` → `edu/belmont/pranish/`
   - If you chose `com.john.auth` → `com/john/auth/`

---

### Method 2: Manual Changes (If IDE refactoring doesn't work)

If you prefer to do it manually or your IDE doesn't support refactoring, follow these steps:

> **Remember**: Replace the example paths with YOUR chosen package name!

#### A. Update Directory Structure

1. **Navigate to**:
   ```bash
   cd simple-login-backend/src/main/java
   ```

2. **Create YOUR new directory structure**:
   
   Convert your package name to a path:
   - `edu.belmont.pranish` → `edu/belmont/pranish`
   - `com.john.auth` → `com/john/auth`
   
   ```bash
   # Replace with YOUR package path
   mkdir -p YOUR/PACKAGE/PATH
   
   # Example: mkdir -p edu/belmont/pranish
   # Example: mkdir -p com/john/auth
   ```

3. **Move all files**:
   ```bash
   # Replace YOUR/PACKAGE/PATH with your actual path
   mv com/example/simpleloginbackend/* YOUR/PACKAGE/PATH/
   ```

4. **Delete old directories**:
   ```bash
   rm -rf com
   ```

5. **Do the same for test directory**:
   ```bash
   cd ../../test/java
   
   # Replace with YOUR package path
   mkdir -p YOUR/PACKAGE/PATH
   mv com/example/simpleloginbackend/* YOUR/PACKAGE/PATH/
   rm -rf com
   ```

#### B. Update Package Declarations in ALL Java Files

Open each `.java` file in YOUR package directory and its subdirectories and change:

**OLD:**
```java
package com.example.simpleloginbackend;
```

**NEW (Replace with YOUR package):**
```java
package YOUR.PACKAGE.NAME;

// Examples:
// package edu.belmont.pranish;
// package com.john.auth;
// package org.myteam.login;
```

**Files to update:**
- `SimpleLoginBackendApplication.java`
- `config/CorsConfig.java`
- `config/DataSeeder.java`
- `config/JwtConfig.java`
- `config/SecurityConfig.java`
- `controller/AuthController.java`
- `model/LoginRequest.java`
- `model/UserDocument.java`
- `repository/UserRepository.java`
- `service/AuthService.java`
- `service/JwtService.java`

**Also update all import statements** that reference the old package:

**OLD:**
```java
import com.example.simpleloginbackend.model.LoginRequest;
import com.example.simpleloginbackend.service.AuthService;
```

**NEW (Replace with YOUR package):**
```java
import YOUR.PACKAGE.NAME.model.LoginRequest;
import YOUR.PACKAGE.NAME.service.AuthService;

// Examples:
// import edu.belmont.pranish.model.LoginRequest;
// import com.john.auth.service.AuthService;
```

#### C. Update Maven Configuration

**File:** `simple-login-backend/pom.xml`

**OLD:**
```xml
<groupId>com.example</groupId>
<artifactId>simple-login-backend</artifactId>
```

**NEW (Replace with YOUR choices):**
```xml
<groupId>YOUR.PACKAGE.NAME</groupId>
<artifactId>YOUR-PROJECT-NAME</artifactId>

<!-- Examples:
<groupId>edu.belmont.pranish</groupId>
<artifactId>my-login-app</artifactId>

<groupId>com.john.auth</groupId>
<artifactId>johns-auth-project</artifactId>
-->
```

#### D. Update Application Properties (Optional but Recommended)

**File:** `simple-login-backend/src/main/resources/application.properties`

**Change logging configuration to YOUR package:**
```properties
# OLD
logging.level.com.example.simpleloginbackend=INFO

# NEW (Replace with YOUR package)
logging.level.YOUR.PACKAGE.NAME=INFO

# Examples:
# logging.level.edu.belmont.pranish=INFO
# logging.level.com.john.auth=INFO
```

---

## 🧪 Step 4: Test Your Changes

1. **Clean and rebuild**:
   ```bash
   cd simple-login-backend
   ./mvnw clean package
   ```

2. **Expected output**:
   ```
   [INFO] BUILD SUCCESS
   ```

3. **Run the application**:
   ```bash
   ./mvnw spring-boot:run
   ```

4. **Verify it starts**:
   ```
   Started SimpleLoginBackendApplication in X.XXX seconds
   ```

5. **Test the API**:
   ```bash
   curl -X POST http://localhost:8080/api/login \
     -H "Content-Type: application/json" \
     -d '{"username":"admin","password":"password"}'
   ```

✅ **If you get a token back, your package rename was successful!**

---

## 🔄 Step 5: Create Your Own Private Repository

### Option A: Fork to Your Account (Recommended)

1. **Go to the original repository** on GitHub

2. **Click "Fork"** button (top right)

3. **Choose your account** as the destination

4. **After forking, go to Settings** → **Change repository visibility to Private**

5. **Update your local repository**:
   ```bash
   cd substitute-teacher
   git remote set-url origin https://github.com/YOUR-USERNAME/PROJECT-NAME.git
   git push -u origin main
   ```

---

### Option B: Create Fresh Repository

1. **Create a new private repository** on GitHub:
   - Go to https://github.com/new
   - Name: `simple-login-app` (or your choice)
   - Visibility: **Private** ✅
   - Don't initialize with README
   - Click "Create repository"

2. **Update your local repository**:
   ```bash
   cd substitute-teacher
   
   # Remove old remote
   git remote remove origin
   
   # Add your new remote
   git remote add origin https://github.com/YOUR-USERNAME/PROJECT-NAME.git
   
   # Push to your new repository
   git push -u origin main
   ```

---

## 📋 Step 6: Update Documentation

Update these files to reflect YOUR changes:

### 1. `README.md`
Change any references from `com.example` to YOUR package name.

### 2. Add Your Information
Update the README to add YOUR details:
```markdown
## 👨‍💻 Author

**YOUR-NAME**
- Institution: YOUR-INSTITUTION
- Package: YOUR.PACKAGE.NAME
- Project: YOUR-PROJECT-NAME

<!-- Examples:
## 👨‍💻 Author

**Pranish Bhagat**
- Institution: Belmont University
- Package: edu.belmont.pranish
- Project: my-login-app

## 👨‍💻 Author

**John Smith**
- Institution: My University
- Package: com.john.auth
- Project: johns-auth-system
-->
```

---

## ✅ Checklist: Verify Everything Works

- [ ] All Java files use your new package name
- [ ] Project builds successfully (`./mvnw clean package`)
- [ ] Application starts without errors
- [ ] API endpoints respond correctly
- [ ] Tests pass (if you run `./mvnw test`)
- [ ] Repository is private on GitHub
- [ ] You can push changes to your repository

---

## 🆘 Troubleshooting

### Issue: "Package does not exist" errors

**Solution:** Make sure all import statements are updated to use your new package name.

```bash
# Search for old package references
grep -r "com.example.simpleloginbackend" simple-login-backend/src/
```

If any are found, update them to your new package.

---

### Issue: Build fails after renaming

**Solution:** Clean and rebuild:
```bash
./mvnw clean
./mvnw compile
```

---

### Issue: Can't push to new repository

**Solution:** Make sure you have access:
```bash
# Test your connection
git remote -v

# Should show your new repository URL
origin  https://github.com/YOUR-USERNAME/simple-login-app.git (fetch)
origin  https://github.com/YOUR-USERNAME/simple-login-app.git (push)
```

---

## 🎓 Learning Outcomes

After completing this guide, you will:

- ✅ Understand Java package naming conventions
- ✅ Know how to refactor package structures
- ✅ Be able to update Maven/Gradle configurations
- ✅ Understand Git remote repository management
- ✅ Have your own customized version of the project

---

## 📚 Additional Resources

- **Java Package Naming**: [Oracle Java Naming Conventions](https://docs.oracle.com/javase/tutorial/java/package/namingpkgs.html)
- **Git Remotes**: [Git Remote Documentation](https://git-scm.com/book/en/v2/Git-Basics-Working-with-Remotes)
- **Maven GroupId**: [Maven Naming Conventions](https://maven.apache.org/guides/mini/guide-naming-conventions.html)

---

## 🎯 Next Steps

After making this project your own:

1. **Customize further** - Add your own features
2. **Deploy it** - Try deploying to Heroku, AWS, or other platforms
3. **Share it** - Add it to your portfolio
4. **Learn more** - Explore Spring Boot features

---

**Good luck making this project your own!** 🚀

If you have questions, reach out to your instructor or check the documentation in `docs/for-developers/`.

## 🗂️ Optional: Rename the Backend and Frontend Folders

You can rename the project folders to anything you like (for example, rename `simple-login-backend` to `my-backend` and `simple-login-frontend` to `my-frontend`). Follow these steps to keep everything working.

### 1) Pick your new folder names
- **Backend folder**: `________________________` (e.g., `my-backend`)
- **Frontend folder**: `________________________` (e.g., `my-frontend`)

### 2) Stop anything running
```bash
npm run stop 2>/dev/null || true
```

### 3) Rename the folders (use git so history is preserved)
```bash
cd /Users/bhagatpranish/Documents/substitute-teacher

git mv simple-login-backend YOUR-BACKEND-FOLDER

git mv simple-login-frontend YOUR-FRONTEND-FOLDER
```

### 4) Update references to the old folder names
Use this search to see all places that reference the original names:
```bash
grep -R "simple-login-backend\|simple-login-frontend" -n .
```
Update the matches below at a minimum:

- **Full Docker compose (if you use it)**: `docs/for-developers/docker-compose.full.yml`
  - Update build contexts:
    - `context: ../../simple-login-backend` → `context: ../../YOUR-BACKEND-FOLDER`
    - `context: ../../simple-login-frontend` → `context: ../../YOUR-FRONTEND-FOLDER`
  - Optionally update container names (purely cosmetic):
    - `container_name: simple-login-backend` → `container_name: YOUR-BACKEND-FOLDER`
    - `container_name: simple-login-frontend` → `container_name: YOUR-FRONTEND-FOLDER`

- **Scripts** in `scripts/` that `cd` into these folders:
  - `scripts/build.sh`
  - `scripts/dev.sh`
  - `scripts/start-all.sh`
  - Any other custom scripts you add
  
  Update occurrences of:
  - `cd simple-login-backend` → `cd YOUR-BACKEND-FOLDER`
  - `cd simple-login-frontend` → `cd YOUR-FRONTEND-FOLDER`

- **Docs/README references** (optional but recommended for clarity):
  - `README.md`
  - `docs/**` where the old folder names appear in examples

Notes:
- The root `docker-compose.yml` only runs MongoDB and does not reference folder names.
- The frontend uses `VITE_API_BASE_URL` for the backend URL; folder names don’t affect this.

### 5) Verify
- Re-run the search to ensure nothing is missed:
```bash
grep -R "simple-login-backend\|simple-login-frontend" -n .
```
- Start dev setup again:
```bash
npm run dev
```
- If you use the full Docker setup, build it from the `docs/for-developers` folder after updating the compose file:
```bash
cd docs/for-developers
docker compose -f docker-compose.full.yml build --no-cache
docker compose -f docker-compose.full.yml up -d
```

### 6) Commit your changes
```bash
git add -A
git commit -m "chore: rename frontend/backend folders and update references"
```

> Tip: If something doesn’t start, check the logs and re-run the grep to find any missed references.

### 🛠️ Make Folder Names Work Automatically (Recommended)

Instead of changing scripts, you can set your folder names as environment variables:

**Create a `.env` file in your project root (if it doesn't exist) and add lines like:**

```env
BACKEND_FOLDER=my-backend
FRONTEND_FOLDER=my-frontend
```

Or set them in your shell before running scripts:

```bash
export BACKEND_FOLDER=my-backend
export FRONTEND_FOLDER=my-frontend
```

> All provided scripts now use these variables, so you only need to set them ONCE—even after renaming the folders!


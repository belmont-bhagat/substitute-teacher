# 🎨 Make This Project Your Own

**For Students: Customize this project with your own package name and private repository**

This guide will help you transform this template project into your own personalized version with your custom package structure and private GitHub repository.

---

## 📚 What You'll Learn

- How to rename Java packages in a Spring Boot project
- How to update all configuration files
- How to create your own private GitHub repository
- Best practices for package naming

---

## 🎯 Step 1: Choose Your Package Name

### Package Naming Convention

Follow the reverse domain name convention:
```
edu.institution.yourname
```

**Examples:**
- `edu.belmont.pranish` - Belmont University, student Pranish
- `edu.vanderbilt.john` - Vanderbilt University, student John
- `edu.myschool.jane` - My School, student Jane
- `com.yourname.project` - Personal project

**Rules:**
- ✅ All lowercase
- ✅ No special characters except dots (.)
- ✅ Use your institution's domain (edu, com, org)
- ✅ End with your name or username

---

## 🔧 Step 2: Rename the Package Structure

### Current Package Structure:
```
com.example.simpleloginbackend
```

### Your New Package (Example):
```
edu.belmont.pranish
```

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

5. **Enter your new package name**: `edu.belmont.pranish`

6. **Click "Refactor"** - Your IDE will automatically:
   - Rename all package declarations
   - Update all import statements
   - Move files to new directory structure
   - Update references in configuration files

7. **Verify the new structure**:
   ```
   simple-login-backend/src/main/java/edu/belmont/pranish/
   ```

---

### Method 2: Manual Changes (If IDE refactoring doesn't work)

If you prefer to do it manually or your IDE doesn't support refactoring, follow these steps:

#### A. Update Directory Structure

1. **Navigate to**:
   ```bash
   cd simple-login-backend/src/main/java
   ```

2. **Create new directory structure**:
   ```bash
   mkdir -p edu/belmont/pranish
   ```

3. **Move all files**:
   ```bash
   mv com/example/simpleloginbackend/* edu/belmont/pranish/
   ```

4. **Delete old directories**:
   ```bash
   rm -rf com
   ```

5. **Do the same for test directory**:
   ```bash
   cd ../../test/java
   mkdir -p edu/belmont/pranish
   mv com/example/simpleloginbackend/* edu/belmont/pranish/
   rm -rf com
   ```

#### B. Update Package Declarations in ALL Java Files

Open each `.java` file in `edu/belmont/pranish/` and its subdirectories and change:

**OLD:**
```java
package com.example.simpleloginbackend;
```

**NEW:**
```java
package edu.belmont.pranish;
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

**NEW:**
```java
import edu.belmont.pranish.model.LoginRequest;
import edu.belmont.pranish.service.AuthService;
```

#### C. Update Maven Configuration

**File:** `simple-login-backend/pom.xml`

**OLD:**
```xml
<groupId>com.example</groupId>
<artifactId>simple-login-backend</artifactId>
```

**NEW:**
```xml
<groupId>edu.belmont.pranish</groupId>
<artifactId>simple-login-backend</artifactId>
```

#### D. Update Application Properties (Optional but Recommended)

**File:** `simple-login-backend/src/main/resources/application.properties`

**Change logging configuration:**
```properties
# OLD
logging.level.com.example.simpleloginbackend=INFO

# NEW
logging.level.edu.belmont.pranish=INFO
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
   git remote set-url origin https://github.com/YOUR-USERNAME/substitute-teacher.git
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
   git remote add origin https://github.com/YOUR-USERNAME/simple-login-app.git
   
   # Push to your new repository
   git push -u origin main
   ```

---

## 📋 Step 6: Update Documentation

Update these files to reflect your changes:

### 1. `README.md`
Change any references from `com.example` to your package name.

### 2. Add Your Name
Update the README to add:
```markdown
## 👨‍💻 Author

**Your Name**
- Institution: Belmont University
- Package: edu.belmont.pranish
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


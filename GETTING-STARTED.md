# 🚀 Getting Started - Simple Login Application

**For Students: A beginner-friendly guide to run this project in Cursor**

## What You'll Need

Before starting, make sure you have these installed:

1. **Java 21** - Download from: https://adoptium.net/temurin/releases/
   - *What it does*: Runs the backend server (Spring Boot)
   
2. **Docker Desktop** - Download from: https://www.docker.com/products/docker-desktop/
   - *What it does*: Runs MongoDB database in an isolated container (like a mini virtual machine)
   
3. **Node.js 18+** - Download from: https://nodejs.org/
   - *What it does*: Runs the frontend development server (Vite)

> 💡 **Tip**: Install these one at a time and restart your computer after installing Java and Docker.

---

## Step 1: Open Project in Cursor

1. Open **Cursor** (the AI code editor)
2. Click **File** → **Open Folder**
3. Select the `substitute-teacher` folder
4. Wait for Cursor to load the project

---

## Step 2: Set Up Java (Mac Users)

Open a **new terminal** in Cursor (Terminal → New Terminal) and run:

```bash
export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"
```

**Verify Java is working:**
```bash
java -version
```
You should see: `openjdk version "21..."`

> 💡 **Windows Users**: Java should work automatically after installation. Just verify with `java -version`.

---

## Step 3: Start the Database

In your Cursor terminal:

```bash
docker compose up -d mongodb
```

**Check it's running:**
```bash
docker ps
```
You should see a container named `mongodb-simple-login` running.

---

## Step 4: Start the Backend (Spring Boot)

In the same terminal:

```bash
cd login-backend
./mvnw spring-boot:run
```

**You'll see Maven downloading files (this is normal!):**
```
Downloading from central: https://repo.maven.apache.org/maven2/...
[INFO] Building jar: /path/to/simple-login-backend-0.0.1-SNAPSHOT.jar
```

**Wait for this SUCCESS message:**
```
Started SimpleLoginBackendApplication in X.XXX seconds (JVM running for X.XXX)
```

> ⏱️ **First time?** This will take 2-3 minutes to download dependencies. Be patient!  
> 💡 **The terminal will show lots of text - this is good!** Don't close it.

---

## Step 5: Start the Frontend (React)

**⚠️ IMPORTANT: Open a NEW terminal window!**

```
Terminal 1: Backend (keep running) ✅
Terminal 2: Frontend (open now) 👈 You are here
```

In the **NEW terminal**:

```bash
cd login-frontend
npm install
npm run dev
```

**Wait for this SUCCESS message:**
```
  VITE v5.x.x  ready in XXX ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: use --host to expose
```

> 💡 **You should now have TWO terminals running:**  
> - Terminal 1: Backend (showing "Started SimpleLoginBackendApplication")  
> - Terminal 2: Frontend (showing "VITE ready")

---

## Step 6: Open the Application

Open your browser and go to:

**http://localhost:5173**

**What you should see:**
```
┌─────────────────────────────┐
│                             │
│    🔐 Simple Login App      │
│                             │
│    [Username field]         │
│    [Password field]         │
│    [  Sign In button  ]     │
│                             │
└─────────────────────────────┘
```

### Test Login:
- **Username**: `admin`
- **Password**: `password`

**After clicking "Sign In":**
- ✅ You'll see your profile page with "Welcome, admin!"
- ✅ You'll see a "Users" button (showing all registered users)
- ✅ You'll see a "Logout" button

---

## 🎉 Success! You're Done!

**You should see:**

1. ✅ **Login page** - Clean form with username/password fields
2. ✅ **Profile page** (after login) - Shows "Welcome, admin!" 
3. ✅ **Users list** - Click "Users" to see all registered users
4. ✅ **No errors** in either terminal window

**Your terminals should show:**
```
Terminal 1 (Backend): "Started SimpleLoginBackendApplication..." ✅
Terminal 2 (Frontend): "VITE ready in XXX ms" ✅
```

> 🎊 **Congratulations!** You've successfully set up a full-stack application!

---

## 🛑 How to Stop Everything

Press `Ctrl+C` in both terminal windows (backend and frontend)

Then stop MongoDB:
```bash
docker compose down
```

---

## 🤦 Common Mistakes (Check These First!)

Before diving into troubleshooting, make sure you didn't make these common mistakes:

### ❌ **Mistake 1: Forgot to start Docker Desktop**
**Symptom**: MongoDB connection errors  
**Fix**: Open Docker Desktop app and wait for it to fully start (whale icon shows "running")

### ❌ **Mistake 2: Only opened ONE terminal**
**Symptom**: Frontend doesn't start, or backend stops  
**Fix**: You need TWO terminal windows:
- Terminal 1: Backend (must stay open)
- Terminal 2: Frontend (must stay open)

### ❌ **Mistake 3: Closed the backend terminal**
**Symptom**: Frontend shows "Network Error" or "Failed to fetch"  
**Fix**: Keep both terminals open while using the app!

### ❌ **Mistake 4: Forgot to run `npm install`**
**Symptom**: Frontend errors about missing modules  
**Fix**: Run `npm install` in the `simple-login-frontend` folder

### ❌ **Mistake 5: Wrong Java version**
**Symptom**: "Unsupported class file major version" error  
**Fix**: Make sure you're using Java 21 (run `java -version` to check)

### ❌ **Mistake 6: Ran commands in wrong directory**
**Symptom**: "command not found" or "No such file or directory"  
**Fix**: Make sure you're in the correct folder:
- For backend: `cd login-backend`
- For frontend: `cd login-frontend`

---

## ❌ Troubleshooting

### Problem: "Port 8080 already in use"
**Solution:** Something else is using port 8080. Find and stop it:
```bash
# Mac/Linux
lsof -i :8080
# Then kill the process ID shown

# Windows
netstat -ano | findstr :8080
```

### Problem: "Cannot connect to Docker"
**Solution:** 
1. Open Docker Desktop application
2. Wait until the whale icon shows it's running
3. Try the `docker compose up -d mongodb` command again

### Problem: "Java version error"
**Solution:** Run the Java setup commands from Step 2 again in your current terminal.

### Problem: Backend won't start - "Bean definition error"
**Solution:** This is already fixed in the code. Make sure you pulled the latest version:
```bash
git pull origin main
```

### Problem: "npm: command not found"
**Solution:** Install Node.js from https://nodejs.org/ and restart Cursor.

---

## 📱 What Each Part Does

- **MongoDB (Port 27017)**: Stores user data
- **Backend (Port 8080)**: Spring Boot API that handles login
- **Frontend (Port 5173)**: React website you see in the browser

---

## 🎯 Quick Commands Cheat Sheet

```bash
# Start everything (in order):
docker compose up -d mongodb
cd login-backend && ./mvnw spring-boot:run          # Terminal 1
cd login-frontend && npm run dev                    # Terminal 2

# Stop everything:
Ctrl+C in both terminals
docker compose down

# Check what's running:
docker ps                    # Check MongoDB
lsof -i :8080               # Check Backend (Mac/Linux)
lsof -i :5173               # Check Frontend (Mac/Linux)
```

---

## 🆘 Still Having Issues?

1. Make sure Docker Desktop is running
2. Make sure you ran commands in the correct order
3. Check that nothing else is using ports 8080, 5173, or 27017
4. Try restarting Cursor and running the steps again

---

## 🎓 Ready to Learn More?

Once you have it running, check out:
- [README.md](./README.md) - Full project documentation
- [docs/for-developers/api.md](./docs/for-developers/api.md) - API endpoint details
- [docs/for-developers/architecture.md](./docs/for-developers/architecture.md) - How everything connects

**Happy coding!** 🚀


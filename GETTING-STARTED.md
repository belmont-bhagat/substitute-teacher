# 🚀 Getting Started - Simple Login Application

**For Students: A beginner-friendly guide to run this project in Cursor**

## What You'll Need

Before starting, make sure you have these installed:

1. **Java 21** - Download from: https://adoptium.net/temurin/releases/
2. **Docker Desktop** - Download from: https://www.docker.com/products/docker-desktop/
3. **Node.js 18+** - Download from: https://nodejs.org/

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
cd simple-login-backend
./mvnw spring-boot:run
```

**Wait for this message:**
```
Started SimpleLoginBackendApplication in X.XXX seconds
```

> ⏱️ **First time?** This will take 2-3 minutes to download dependencies. Be patient!

---

## Step 5: Start the Frontend (React)

**Open a NEW terminal** (keep the backend running in the first one):

```bash
cd simple-login-frontend
npm install
npm run dev
```

**Wait for:**
```
VITE ready in XXX ms
Local: http://localhost:5173/
```

---

## Step 6: Open the Application

Open your browser and go to:

**http://localhost:5173**

### Test Login:
- **Username**: `admin`
- **Password**: `password`

---

## ✅ Success! You Should See:

1. A login page
2. After logging in → Your profile page
3. No error messages in the terminal

---

## 🛑 How to Stop Everything

Press `Ctrl+C` in both terminal windows (backend and frontend)

Then stop MongoDB:
```bash
docker compose down
```

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
cd simple-login-backend && ./mvnw spring-boot:run    # Terminal 1
cd simple-login-frontend && npm run dev              # Terminal 2

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
- `README.md` - Full project documentation
- `docs/api.md` - API endpoint details
- `docs/architecture.md` - How everything connects

**Happy coding!** 🚀


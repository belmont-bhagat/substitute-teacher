# ⚡ Quick Reference Card

**Bookmark this page for fast access to common commands!**

---

## 🚀 Start Everything (3 Commands)

```bash
# 1. Start MongoDB
docker compose up -d mongodb

# 2. Start Backend (Terminal 1)
cd <BACKEND_DIR> && ./mvnw spring-boot:run   # default: login-backend

# 3. Start Frontend (Terminal 2 - NEW window!)
cd <FRONTEND_DIR> && npm run dev             # default: login-frontend
```

---

## 🔗 Access Links

- **App**: http://localhost:5173
- **Login**: `admin` / `password`
- **API**: http://localhost:8080/api

---

## 🛑 Stop Everything

```bash
# Stop backend & frontend: Press Ctrl+C in their terminals

# Stop MongoDB:
docker compose down
```

---

## ✅ Check What's Running

```bash
# Check MongoDB
docker ps

# Check if backend is running (Mac/Linux)
lsof -i :8080

# Check if frontend is running (Mac/Linux)
lsof -i :5173
```

---

## 🔧 Common Commands

### Backend (Spring Boot)
```bash
cd <BACKEND_DIR>   # default: login-backend

# Run backend
./mvnw spring-boot:run

# Clean build
./mvnw clean

# Run tests
./mvnw test
```

### Frontend (React)
```bash
cd <FRONTEND_DIR>   # default: login-frontend

# Install dependencies
npm install

# Run dev server
npm run dev

# Build for production
npm run build
```

### Database (Docker)
```bash
# Start MongoDB
docker compose up -d mongodb

# Stop MongoDB
docker compose down

# View MongoDB logs
docker logs mongodb-simple-login

# Access MongoDB shell
docker exec -it mongodb-simple-login mongosh simple_login
```

---

## 🤦 Forgot Something?

### Java Setup (Mac)
```bash
export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-21.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"
java -version  # Verify
```

### Verify Prerequisites
```bash
java -version    # Should show 21.x.x
node -version    # Should show 18.x.x or higher
docker --version # Check Docker is installed
docker ps        # Check Docker is running
```

---

## 📊 Terminal Layout

```
┌─────────────────────────┐  ┌─────────────────────────┐
│   Terminal 1: Backend   │  │   Terminal 2: Frontend  │
│                         │  │                         │
│ $ cd <BACKEND_DIR>      │  │ $ cd <FRONTEND_DIR>     │
│ $ ./mvnw spring-boot:   │  │ $ npm run dev           │
│   run                   │  │                         │
│                         │  │ VITE ready in XXX ms ✅ │
│ Started Backend... ✅   │  │                         │
│                         │  │                         │
│ (Keep open!)            │  │ (Keep open!)            │
└─────────────────────────┘  └─────────────────────────┘
```

---

## 🆘 Quick Troubleshooting

| Problem | Quick Fix |
|---------|-----------|
| "Port 8080 in use" | Something else is using port 8080. Run `lsof -i :8080` and kill it |
| "Cannot connect to Docker" | Open Docker Desktop and wait for it to start |
| "npm: command not found" | Install Node.js from nodejs.org |
| "Java version error" | Run the Java setup commands again |
| Frontend shows errors | Make sure backend is running in Terminal 1 |
| "Network Error" | Backend might have stopped - check Terminal 1 |

---

## 📱 Default Test Users

| Username | Password | Role |
|----------|----------|------|
| admin | password | instructor |
| student1 | password | student |
| student2 | password | student |
| ... | ... | ... |
| student10 | password | student |

---

## 🎯 API Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/api/login` | Login |
| GET | `/api/profile` | Get user profile (needs token) |
| GET | `/api/users` | List all users (needs token) |

---

**Need more help?** → See [GETTING-STARTED.md](./GETTING-STARTED.md)


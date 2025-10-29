# Simple Login Application (No Dashboard Branch)

A full-stack authentication application built with Spring Boot backend and React frontend, designed for educational purposes.

**Features**: Login → Profile (minimal authentication flow for learning)

---

## 🎓 **FOR STUDENTS: Start Here**

**→ New to this project?** Read **[GETTING-STARTED.md](./GETTING-STARTED.md)** for a step-by-step beginner guide.

That guide will walk you through:
- Installing everything you need
- Running the project in Cursor
- Testing the application
- Troubleshooting common issues

---

## 🏗️ Technology Stack

- **Backend**: Spring Boot 3.1.5 + Java 21 LTS + MongoDB
- **Frontend**: React 18 + TypeScript + Vite
- **Authentication**: JWT tokens

---

## 🚀 Quick Start (For Experienced Developers)

### Prerequisites
- Java 21 LTS, Node.js 18+, Docker Desktop

### Three Commands to Run

```bash
# 1. Start database
docker compose up -d mongodb

# 2. Start backend (new terminal)
cd simple-login-backend && ./mvnw spring-boot:run

# 3. Start frontend (another new terminal)  
cd simple-login-frontend && npm install && npm run dev
```

**Access**: http://localhost:5173  
**Login**: `admin` / `password`

> 💡 **Note**: See [GETTING-STARTED.md](./GETTING-STARTED.md) for detailed instructions including Java setup.

## 📁 Project Structure

```
substitute-teacher/
├── simple-login-backend/          # Spring Boot backend
│   ├── src/main/java/            # Java source code
│   ├── src/main/resources/       # Configuration files
│   ├── pom.xml                   # Maven dependencies
│   └── Dockerfile               # Docker configuration
├── simple-login-frontend/        # React frontend (Login + Profile only in this branch)
│   ├── src/                     # React source code
│   ├── public/                  # Static assets
│   ├── package.json            # Node.js dependencies
│   └── vite.config.ts          # Vite configuration
├── postman/                     # API testing collection
│   └── Simple-Login.postman_collection.json
├── docs/                        # Centralized documentation for this branch
│   ├── README.md                # Docs index
│   ├── overview.md              # What this branch includes
│   ├── running.md               # How to run locally
│   ├── api.md                   # Minimal API reference
│   ├── architecture.md          # High-level architecture
│   ├── Project-Outline.md       # Project outline
│   ├── PROJECT-GUIDE.md         # Teaching guide
│   ├── TEST-README.md           # Testing guide
│   └── substitute-teacher-outline.md # Session outline
├── scripts/                     # Utility scripts
│   ├── start-all.sh            # Legacy helper (prefer commands above for this branch)
│   └── stop-all.sh             # Stop all services
├── docker-compose.yml          # Docker services configuration
├── GETTING-STARTED.md          # 🎓 Beginner guide (START HERE!)
├── RUNNING-NOTES.md            # Quick reference for running the app
└── README.md                   # This file
```

## 🔧 Development Tips

- **Backend**: Runs on port 8080, auto-reloads on code changes
- **Frontend**: Runs on port 5173, hot module replacement enabled  
- **Database**: MongoDB auto-seeds with 11 test users (1 admin + 10 students)
- **Default Users**: `admin/password`, `student1/password` through `student10/password`

## 📚 API Endpoints

**Base URL**: `http://localhost:8080/api`

| Method | Endpoint | Description | Auth Required |
|--------|----------|-------------|---------------|
| POST | `/login` | User authentication | No |
| GET | `/profile` | Get user profile | Yes (JWT) |
| GET | `/users` | List all users | Yes (JWT) |

**Full API documentation**: See [docs/api.md](./docs/api.md)

## 🎓 Documentation

- **[GETTING-STARTED.md](./GETTING-STARTED.md)** - Beginner-friendly setup guide
- **[docs/api.md](./docs/api.md)** - API endpoint reference
- **[docs/architecture.md](./docs/architecture.md)** - System architecture
- **[docs/overview.md](./docs/overview.md)** - What's included in this branch
- **Teaching Materials** - See `docs/PROJECT-GUIDE.md` and `docs/substitute-teacher-outline.md`

## 🛑 Stopping the Application

```bash
# Stop backend & frontend: Press Ctrl+C in their terminals

# Stop MongoDB:
docker compose down
```

---

## 📄 License

MIT License - See [LICENSE](LICENSE) file for details.

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## 🆘 Having Issues?

**→ See [GETTING-STARTED.md](./GETTING-STARTED.md#-troubleshooting)** for detailed troubleshooting steps.

**Common quick fixes:**
- Docker not running? Open Docker Desktop first
- Port conflicts? Check if something is using ports 8080, 5173, or 27017
- Java errors? Make sure Java 21 is installed and JAVA_HOME is set

---

**Built for educational purposes** 🎓
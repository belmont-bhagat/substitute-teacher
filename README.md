# Simple Login Application

A full-stack authentication application built with Spring Boot backend and React frontend, designed for educational purposes.

**Features**: Login → Profile (minimal authentication flow for learning)

> 💡 **Note**: This is the simplified version. For the full-featured version with dashboard, see the `dashboard` branch.

---

## 🎓 **FOR STUDENTS: Start Here**

**→ New to this project?** Read **[GETTING-STARTED.md](./GETTING-STARTED.md)** for a step-by-step beginner guide.

**→ Need quick commands?** Bookmark **[QUICK-REFERENCE.md](./QUICK-REFERENCE.md)** for a one-page cheat sheet!

That guide will walk you through:
- Installing everything you need
- Running the project in Cursor
- Testing the application
- Troubleshooting common issues

---

## 🏗️ Technology Stack

- **Backend**: Spring Boot 3.5.7 + Java 21 LTS + MongoDB
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
├── README.md                      # ⭐ You are here!
├── GETTING-STARTED.md             # 🎓 Beginner guide (START HERE!)
├── QUICK-REFERENCE.md             # ⚡ Command cheat sheet (BOOKMARK THIS!)
│
├── simple-login-backend/          # ☕ Spring Boot backend
├── simple-login-frontend/         # ⚛️ React frontend
│
├── docs/                          # 📚 All documentation
│   ├── README.md                  # Documentation index
│   ├── for-students/              # 🎓 Student resources
│   ├── for-developers/            # 💻 Technical docs
│   ├── for-instructors/           # 👨‍🏫 Teaching materials
│   └── admin/                     # 🔧 Setup & maintenance
│
├── tests/                         # 🧪 Integration tests
│   ├── README.md                  # Testing guide
│   └── integration/               # Test files
│
├── postman/                       # 📬 API testing collection
└── docker-compose.yml             # 🐳 Docker configuration
```

**Where should I look?**
- **Student?** → Start with [GETTING-STARTED.md](./GETTING-STARTED.md)
- **Developer?** → Check [docs/for-developers/](./docs/for-developers/)
- **Instructor?** → See [docs/for-instructors/](./docs/for-instructors/)
- **Testing?** → Go to [tests/](./tests/)

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

**Full API documentation**: See [docs/for-developers/api.md](./docs/for-developers/api.md)

## 🎓 Documentation

Documentation is now organized by role in the `docs/` folder:

- **[docs/for-students/](./docs/for-students/)** - Student guides and quick references
- **[docs/for-developers/](./docs/for-developers/)** - API, architecture, technical specs  
- **[docs/for-instructors/](./docs/for-instructors/)** - Teaching materials and lesson plans
- **[docs/admin/](./docs/admin/)** - Repository setup and maintenance

**Complete documentation index**: [docs/README.md](./docs/README.md)

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

See [docs/admin/CONTRIBUTING.md](./docs/admin/CONTRIBUTING.md) for guidelines.

## 🆘 Having Issues?

**→ See [GETTING-STARTED.md](./GETTING-STARTED.md#-troubleshooting)** for detailed troubleshooting steps.

**Common quick fixes:**
- Docker not running? Open Docker Desktop first
- Port conflicts? Check if something is using ports 8080, 5173, or 27017
- Java errors? Make sure Java 21 is installed and JAVA_HOME is set

---

**Built for educational purposes** 🎓
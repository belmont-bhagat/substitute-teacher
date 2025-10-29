# 💻 For Developers

**Technical documentation for developers working on this project**

## 📋 Documentation

### [api.md](./api.md)
Complete API endpoint reference with request/response examples.

### [architecture.md](./architecture.md)
System architecture, technology stack, and authentication flow.

### [overview.md](./overview.md)
Project overview - what's included in this no-dashboard branch.

---

## 🛠️ Technical Stack

- **Backend**: Spring Boot 3.1.5, Java 21 LTS
- **Frontend**: React 18, TypeScript, Vite
- **Database**: MongoDB (Docker)
- **Authentication**: JWT (HMAC-SHA256)

## 🔧 Development Setup

For setup instructions, see the main [README.md](../../README.md).

For detailed development workflows, check the component READMEs:
- Backend: `simple-login-backend/README.md`
- Frontend: `simple-login-frontend/README.md`

---

## 📡 API Endpoints

**Base URL**: `http://localhost:8080/api`

| Method | Endpoint | Description |
|--------|----------|-------------|
| POST | `/login` | User authentication |
| GET | `/profile` | Get user profile (requires JWT) |
| GET | `/users` | List all users (requires JWT) |

Full API documentation in [api.md](./api.md)

---

## 🧪 Testing

Integration tests are located in the `tests/` directory at the root level.

---

**Need help?** Open an issue or check the troubleshooting guide.


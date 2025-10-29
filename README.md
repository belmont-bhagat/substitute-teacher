# Simple Login Application (No Dashboard Branch)

A full-stack authentication application built with Spring Boot backend and React frontend, designed for educational purposes and teaching software engineering concepts.

This branch focuses on a minimal flow (Login → Profile). The dashboard implementation and routes have been removed for simplicity.

## 🏗️ Architecture

- **Backend**: Spring Boot 3.1.5 with Java 21 LTS
- **Frontend**: React 18 with TypeScript and Vite
- **Database**: MongoDB with Docker
- **Authentication**: JWT-based authentication
- **Styling**: Tailwind CSS

## 🚀 Quick Start

> 📝 **Quick Reference**: See [RUNNING-NOTES.md](./RUNNING-NOTES.md) for a condensed version of startup instructions and troubleshooting.

### Prerequisites

- Java 21 LTS or higher
- Node.js 18 or higher (npm 9+ recommended)
- Docker and Docker Compose
- Maven (included via Maven Wrapper - `mvnw` script, no separate installation needed)

### Installation & Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd substitute-teacher
   ```

2. **Start MongoDB (Docker)**
   ```bash
   docker compose up -d mongodb
   ```

3. **Start the backend (Java 21)**
   ```bash
   cd simple-login-backend
   # JAVA_HOME must be properly set to Java 21 (example for macOS/Homebrew)
   export JAVA_HOME=/opt/homebrew/opt/openjdk@21
   
   # Use a strong JWT secret (>= 64 chars) for better security
   # Note: For quick development, you can omit the JWT secret to use the default
   ./mvnw spring-boot:run \
     -Dspring-boot.run.jvmArguments="-Dspring.data.mongodb.uri=mongodb://localhost:27017/simple_login -Dauth.jwt.secret=0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
   ```

4. **Start the frontend (Vite dev server)**
   ```bash
   cd simple-login-frontend
   npm install
   npm run dev
   ```

5. **Access the application**
   - Frontend: http://localhost:5173
   - Backend API: http://localhost:8080
   - MongoDB: mongodb://localhost:27017

### Default Credentials

- **Username**: `admin`
- **Password**: `password`

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
├── RUNNING-NOTES.md            # Quick reference for running the app
└── README.md                   # This file
```

## 🔧 Development

### Backend Development

```bash
cd simple-login-backend

# JAVA_HOME must be properly set to Java 21
export JAVA_HOME=/opt/homebrew/opt/openjdk@21

# Run the application (uses default JWT secret from application.properties)
./mvnw spring-boot:run
```

> **Note:** The Development setup uses the default JWT secret from `application.properties` which is fine for local development. For production or when testing with real data, use a strong custom JWT secret as shown in the Installation & Setup section above.

### Frontend Development

```bash
cd simple-login-frontend

# Install dependencies
npm install

# Start development server
npm run dev
```

### Database

MongoDB runs in a Docker container. The database is automatically seeded with sample users on startup.

## 🧪 API Testing

Import the Postman collection from `postman/Simple-Login.postman_collection.json`:

1. Open Postman
2. Import the collection file
3. Set the `base_url` environment variable to `http://localhost:8080`
4. Run the requests in order:
   - Login (POST /api/login)
   - Profile (GET /api/profile)
   - List Users (GET /api/users)

## 📚 API Endpoints

### Authentication

- `POST /api/login` - User login
  - Body: `{"username": "admin", "password": "password"}`
  - Response: `{"token": "jwt-token"}`

- `GET /api/profile` - Get user profile
  - Headers: `Authorization: Bearer <token>`
  - Response: `{"username": "admin", "role": "instructor"}`

- `GET /api/users` - List all users
  - Headers: `Authorization: Bearer <token>`
  - Response: `{"users": [...], "count": 11}`

## 🎓 Teaching Materials

This project includes comprehensive teaching materials in the `docs/` directory:

- **docs/Project-Outline.md**: Detailed project architecture and implementation plan
- **docs/substitute-teacher-outline.md**: 75-minute teaching session plan
- **postman/Simple-Login.postman_collection.json**: Ready-to-use API testing collection

### Teaching Session Overview

The teaching plan covers:
1. Backend architecture (Spring Boot + MongoDB + JWT)
2. Postman API demonstration
3. Frontend walkthrough (React + TypeScript)
4. Live dashboard development with Cursor AI (not applicable in this branch)

## 🛠️ Scripts

- `./scripts/start-all.sh` - Legacy: may not reflect branch changes; use commands above
- `./scripts/stop-all.sh` - Stop all services and clean up

## 🔒 Security Features

- JWT-based authentication
- Password hashing with BCrypt
- CORS configuration
- Input validation
- Role-based access control

## 📝 Environment Variables (Optional)

Instead of passing configuration via command-line arguments (as shown in Installation & Setup), you can optionally set environment variables that Spring Boot will automatically read from `application.properties`.

To use environment variables, export them in your shell before starting the backend:

```bash
# Set environment variables (alternative to command-line args)
export AUTH_JWT_SECRET=0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
export MONGO_URI=mongodb://localhost:27017/simple_login
export JAVA_HOME=/opt/homebrew/opt/openjdk@21

# Then start the backend without command-line args
cd simple-login-backend
./mvnw spring-boot:run
```

**When to use:**
- ✅ Environment variables: Better for persistent development setup
- ✅ Command-line arguments: Better for one-off runs or testing different configurations

> **Note:** If not set, the backend uses defaults from `application.properties` (see `simple-login-backend/src/main/resources/application.properties`)

## 🐳 Docker Management

Useful Docker commands for managing the MongoDB container:

```bash
# View MongoDB logs
docker logs mongodb-simple-login

# Stop MongoDB
docker compose down mongodb

# Restart MongoDB
docker restart mongodb-simple-login

# Access MongoDB shell
docker exec -it mongodb-simple-login mongosh simple_login

# View running containers
docker ps
```

> **Note:** Full Docker Compose deployment (with frontend/backend images) may fail in this branch due to build constraints. The recommended setup is: Docker for MongoDB + local Spring Boot + Vite dev server.

## 🤝 Contributing

This repository is protected to ensure code quality and project integrity.

### How to Contribute

1. **Fork the repository** to your GitHub account
2. **Create a feature branch** in your fork
3. **Make your changes** and test thoroughly
4. **Submit a Pull Request** with a clear description
5. **Wait for approval** - All PRs require owner approval

### Protection Rules

- ✅ **Direct pushes to main are blocked**
- ✅ **All changes require pull request reviews**
- ✅ **At least 1 approval required before merging**
- ✅ **Status checks must pass**
- ✅ **Only owner can merge PRs**

For detailed guidelines, see [CONTRIBUTING.md](CONTRIBUTING.md)

**Note**: As the repository owner, you have exclusive authority to:
- Approve and merge pull requests
- Modify branch protection rules
- Delete protected branches
- Force push (not recommended when protection is enabled)

See [PROTECTION-SETUP.md](PROTECTION-SETUP.md) for complete protection configuration.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Troubleshooting

### Common Issues

1. **Java Version Issues**
   - Ensure Java 21 LTS is installed and JAVA_HOME is properly set
   - Example (macOS/Homebrew): `export JAVA_HOME=/opt/homebrew/opt/openjdk@21`
   - Verify with: `java -version` (should show 21.0.x)

2. **Backend Fails to Start (Bean Override Error)**
   - If you see: "The bean 'corsConfigurationSource' could not be registered"
   - This is already fixed in `application.properties`
   - Ensure you're using the latest version with `spring.main.allow-bean-definition-overriding=true`

3. **MongoDB Connection Issues**
   - Ensure Docker is running
   - Check if MongoDB container is running: `docker ps | grep mongodb`
   - Container should be named: `mongodb-simple-login`

4. **Port Conflicts**
   - Backend: 8080
   - Frontend: 5173
   - MongoDB: 27017
   - Check if ports are in use: `lsof -i :8080` or `lsof -i :5173`

5. **Frontend Not Connecting to Backend**
   - Check if backend is running on port 8080
   - Verify CORS configuration in backend
   - Check browser console for errors

### Getting Help

- Check backend logs: `./mvnw spring-boot:run` output or `logs/` directory (when running with Docker)
- Review the Postman collection for API testing
- Refer to the teaching materials for detailed explanations

---

**Built for educational purposes** - Perfect for teaching full-stack development, authentication, and modern web technologies.
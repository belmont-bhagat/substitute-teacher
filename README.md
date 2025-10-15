# Simple Login Application - Complete Full-Stack Project

A comprehensive full-stack authentication application demonstrating modern web development practices. Perfect for learning full-stack development, authentication systems, and modern tooling.

## 🎯 Features

- ✅ **JWT Authentication**: Secure token-based authentication
- ✅ **User Management**: Role-based access control (instructor/student)
- ✅ **User Dashboard**: Interactive interface with search and filtering
- ✅ **REST API**: Complete backend API with Spring Boot
- ✅ **Modern Frontend**: React with TypeScript and TailwindCSS
- ✅ **Database Integration**: MongoDB with user seeding
- ✅ **API Testing**: Comprehensive Postman collection
- ✅ **Docker Support**: Containerized deployment
- ✅ **Automation Scripts**: Complete setup and deployment automation

## 🏗️ Architecture

- **Backend**: Spring Boot (Java 17), MongoDB, JWT
- **Frontend**: React + TypeScript + Vite + TailwindCSS
- **Database**: MongoDB with user seeding
- **Authentication**: JWT tokens with role-based access
- **Testing**: Postman collection for API testing
- **Deployment**: Docker containers with orchestration

## 🚀 Quick Start

### Prerequisites
- Java 17+ (backend)
- Node.js 18+ (frontend)
- Docker Desktop (for MongoDB) or local MongoDB
- Git

### One-Command Setup
```bash
# Clone and setup everything
git clone https://github.com/belmont-bhagat/substitute-teacher.git
cd substitute-teacher
npm run setup
npm start
```

### Manual Setup

1. **Start MongoDB**:
```bash
docker run -d --name mongodb-simple-login -p 27017:27017 mongo:latest
```

2. **Start Backend**:
```bash
cd simple-login-backend
export JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"
export AUTH_JWT_SECRET='your-super-secure-jwt-secret-key'
./mvnw spring-boot:run
```

3. **Start Frontend**:
```bash
cd simple-login-frontend
npm install
npm run dev
```

## 🌐 Application URLs

- **Frontend**: http://localhost:5173
- **Backend API**: http://localhost:8080
- **MongoDB**: mongodb://localhost:27017/simple_login

## 🔑 Default Login Credentials

- **Admin**: username: `admin`, password: `password`, role: `instructor`
- **Students**: username: `student1` through `student10`, password: `password`, role: `student`

## 📋 Available Scripts

| Command | Description |
|---------|-------------|
| `npm run setup` | Complete project setup and dependency installation |
| `npm start` | Start all services (MongoDB, Backend, Frontend) |
| `npm run stop` | Stop all running services |
| `npm run dev` | Start in development mode with hot reloading |
| `npm run build` | Build project for production |
| `npm test` | Run all tests |
| `npm run clean` | Clean build artifacts and temporary files |

## 📁 Project Structure

```
substitute-teacher/
├── simple-login-backend/          # Spring Boot backend
├── simple-login-frontend/         # React frontend
├── mongo-auth-service/            # Optional Python service
├── postman/                       # API testing collection
├── scripts/                       # Automation scripts
├── docker-compose.yml             # Docker orchestration
├── env.template                   # Environment template
└── PROJECT-GUIDE.md              # Comprehensive documentation
```

## 🧪 API Testing

Import `postman/Simple-Login.postman_collection.json` into Postman:
1. Set environment variable `base_url = http://localhost:8080`
2. Run login request to get JWT token
3. Use token for authenticated requests

## 🐳 Docker Deployment

```bash
# Using Docker Compose
cp env.template .env
docker-compose up -d

# Access at http://localhost:3000
```

## 📚 Documentation

- **[Complete Project Guide](PROJECT-GUIDE.md)**: Comprehensive documentation
- **[API Documentation](postman/Simple-Login.postman_collection.json)**: Postman collection
- **[Backend README](simple-login-backend/README.md)**: Backend-specific documentation
- **[Frontend README](simple-login-frontend/README.md)**: Frontend-specific documentation

## 🛠️ Technology Stack

### Backend
- Java 17+, Spring Boot 3.1.5, MongoDB, JWT, Maven

### Frontend
- React 18.2.0, TypeScript 5.9.3, Vite 7.1.7, TailwindCSS 4.1.14

### Development Tools
- Postman, Docker, Git, VS Code

## 🔒 Security Features

- JWT Authentication with secure token handling
- Password hashing with BCrypt
- CORS configuration
- Input validation
- Environment variable protection

## 🚀 Production Deployment

1. Configure production environment variables
2. Build for production: `npm run build`
3. Deploy using Docker or manual deployment
4. Set up HTTPS, monitoring, and backups

## 🛠️ Troubleshooting

### Common Issues

**Port conflicts**:
```bash
# Kill processes on ports
lsof -t -i:8080 | xargs -r kill -9
lsof -t -i:5173 | xargs -r kill -9
```

**Java version issues**:
```bash
export JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"
```

**MongoDB connection**:
```bash
# Check MongoDB status
docker ps | grep mongo
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

## 🆘 Support

- Check [PROJECT-GUIDE.md](PROJECT-GUIDE.md) for detailed documentation
- Review logs: `tail -f logs/backend.log logs/frontend.log`
- Check [Issues](https://github.com/belmont-bhagat/substitute-teacher/issues)

---

**Perfect for learning full-stack development! 🎓**

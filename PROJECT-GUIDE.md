# Simple Login Application - Complete Project Guide

## 🎯 Project Overview

The Simple Login Application is a comprehensive full-stack web application designed for educational purposes. It demonstrates modern web development practices including authentication, user management, and dashboard functionality.

### Key Features

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

```
┌─────────────────┐    HTTP/HTTPS    ┌─────────────────┐
│   Frontend      │◄─────────────────┤   Backend       │
│   (React)       │                  │   (Spring Boot)  │
│   Port: 5173    │                  │   Port: 8080    │
└─────────────────┘                  └─────────────────┘
                                              │
                                              │ MongoDB Protocol
                                              ▼
                                     ┌─────────────────┐
                                     │   Database      │
                                     │   (MongoDB)     │
                                     │   Port: 27017   │
                                     └─────────────────┘
```

## 🚀 Quick Start

### Prerequisites

- **Java**: JDK 17 or higher
- **Node.js**: Version 18 or higher
- **npm**: Latest version
- **Docker**: Optional, for MongoDB
- **Git**: Latest version

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/belmont-bhagat/substitute-teacher.git
   cd substitute-teacher
   ```

2. **Run complete setup**:
   ```bash
   npm run setup
   ```

3. **Start all services**:
   ```bash
   npm start
   ```

4. **Access the application**:
   - Frontend: http://localhost:5173
   - Backend API: http://localhost:8080
   - MongoDB: mongodb://localhost:27017

### Default Login Credentials

- **Admin**: username: `admin`, password: `password`, role: `instructor`
- **Students**: username: `student1` through `student10`, password: `password`, role: `student`

## 📁 Project Structure

```
substitute-teacher/
├── simple-login-backend/          # Spring Boot backend
│   ├── src/main/java/com/example/simpleloginbackend/
│   │   ├── controller/          # REST controllers
│   │   ├── service/             # Business logic
│   │   ├── repository/          # Data access
│   │   ├── model/               # Data models
│   │   ├── config/              # Configuration
│   │   └── resources/           # Application properties
│   ├── Dockerfile               # Backend container
│   └── pom.xml                  # Maven dependencies
├── simple-login-frontend/        # React frontend
│   ├── src/
│   │   ├── components/          # Reusable UI components
│   │   ├── pages/               # Page components
│   │   ├── lib/                 # Utility functions
│   │   └── main.tsx             # Application entry point
│   ├── Dockerfile               # Frontend container
│   ├── nginx.conf               # Nginx configuration
│   └── package.json             # Frontend dependencies
├── mongo-auth-service/          # Optional Python service
├── postman/                     # API testing collection
├── scripts/                     # Automation scripts
│   ├── setup.sh                 # Complete setup
│   ├── start-all.sh             # Start all services
│   ├── stop-all.sh              # Stop all services
│   ├── dev.sh                   # Development mode
│   ├── build.sh                 # Production build
│   ├── test.sh                  # Run tests
│   └── clean.sh                 # Clean artifacts
├── docker-compose.yml           # Docker orchestration
├── env.template                 # Environment template
├── package.json                 # Root project metadata
├── requirements.txt             # Python dependencies
└── README.md                    # This file
```

## 🔧 Available Scripts

| Script | Command | Description |
|--------|---------|-------------|
| **Setup** | `npm run setup` | Complete project setup and dependency installation |
| **Start** | `npm start` | Start all services (MongoDB, Backend, Frontend) |
| **Stop** | `npm run stop` | Stop all running services |
| **Development** | `npm run dev` | Start in development mode with hot reloading |
| **Build** | `npm run build` | Build project for production |
| **Test** | `npm test` | Run all tests |
| **Clean** | `npm run clean` | Clean build artifacts and temporary files |

## 🛠️ Technology Stack

### Backend
- **Java 17+**: Programming language
- **Spring Boot 3.1.5**: Framework for REST APIs
- **Spring Data MongoDB**: Database integration
- **Maven**: Build and dependency management
- **Lombok**: Reduces boilerplate code
- **JJWT**: JWT token handling
- **MongoDB**: NoSQL database

### Frontend
- **React 18.2.0**: UI framework
- **TypeScript 5.9.3**: Type-safe JavaScript
- **Vite 7.1.7**: Build tool and dev server
- **React Router DOM 6.22.3**: Client-side routing
- **Axios 1.12.2**: HTTP client for API calls
- **TailwindCSS 4.1.14**: Utility-first CSS framework

### Development Tools
- **Postman**: API testing and documentation
- **Git**: Version control
- **Docker**: Containerization
- **VS Code**: Code editor

## 📊 API Documentation

### Base URL
`http://localhost:8080/api`

### Authentication
All endpoints except `/login` require a JWT token in the Authorization header:
```
Authorization: Bearer <jwt_token>
```

### Endpoints

#### POST /login
Authenticate user and receive JWT token.

**Request Body:**
```json
{
  "username": "admin",
  "password": "password"
}
```

**Response:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9..."
}
```

#### GET /profile
Get current user's profile information.

**Headers:**
```
Authorization: Bearer <jwt_token>
```

**Response:**
```json
{
  "username": "admin",
  "role": "instructor"
}
```

#### GET /users
Get list of all users (requires authentication).

**Headers:**
```
Authorization: Bearer <jwt_token>
```

**Response:**
```json
{
  "count": 11,
  "users": [
    {
      "id": "...",
      "username": "admin",
      "email": "admin@example.com",
      "role": "instructor"
    }
  ]
}
```

## 🐳 Docker Deployment

### Using Docker Compose

1. **Configure environment**:
   ```bash
   cp env.template .env
   # Edit .env with your values
   ```

2. **Start all services**:
   ```bash
   docker-compose up -d
   ```

3. **Access the application**:
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:8080
   - MongoDB: mongodb://localhost:27017

### Individual Docker Services

**Backend**:
```bash
cd simple-login-backend
docker build -t simple-login-backend .
docker run -p 8080:8080 simple-login-backend
```

**Frontend**:
```bash
cd simple-login-frontend
docker build -t simple-login-frontend .
docker run -p 3000:80 simple-login-frontend
```

## 🧪 Testing

### API Testing with Postman

1. **Import collection**: `postman/Simple-Login.postman_collection.json`
2. **Set environment variable**: `base_url = http://localhost:8080`
3. **Run login request** to get JWT token
4. **Use token** for authenticated requests

### Automated Testing

```bash
# Run all tests
npm test

# Run backend tests only
cd simple-login-backend && ./mvnw test

# Run frontend tests only
cd simple-login-frontend && npm test
```

## 🔒 Security Features

- **JWT Authentication**: Secure token-based authentication
- **Password Hashing**: BCrypt with salt
- **CORS Configuration**: Proper cross-origin resource sharing
- **Input Validation**: Server-side validation
- **Error Handling**: Secure error responses
- **Environment Variables**: Sensitive data protection

## 🚀 Production Deployment

### Environment Configuration

1. **Set production environment**:
   ```bash
   NODE_ENV=production
   AUTH_JWT_SECRET=your-production-secret-key
   MONGO_URI=mongodb://your-production-mongo-host:27017/simple_login
   ```

2. **Build for production**:
   ```bash
   npm run build
   ```

3. **Deploy**:
   ```bash
   # Using Docker
   docker-compose -f docker-compose.prod.yml up -d
   
   # Or manual deployment
   # Deploy backend JAR and frontend static files
   ```

### Production Checklist

- [ ] Update JWT secret
- [ ] Configure MongoDB connection
- [ ] Set up HTTPS certificates
- [ ] Configure reverse proxy (nginx/Apache)
- [ ] Set up monitoring and logging
- [ ] Configure backup strategy
- [ ] Test all endpoints
- [ ] Set up CI/CD pipeline

## 🛠️ Development

### Adding New Features

1. **Backend**: Add controllers, services, and repositories
2. **Frontend**: Add components and pages
3. **Database**: Update models and migrations
4. **Testing**: Add unit and integration tests
5. **Documentation**: Update API documentation

### Code Style

- **Backend**: Follow Spring Boot conventions
- **Frontend**: Use TypeScript strict mode
- **Database**: Use MongoDB best practices
- **Testing**: Maintain high test coverage

## 📚 Learning Resources

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [React Documentation](https://reactjs.org/docs)
- [MongoDB Documentation](https://docs.mongodb.com)
- [JWT.io](https://jwt.io)
- [TypeScript Handbook](https://www.typescriptlang.org/docs)
- [TailwindCSS Documentation](https://tailwindcss.com/docs)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

If you encounter any issues:

1. Check the troubleshooting section below
2. Review the logs: `tail -f logs/backend.log logs/frontend.log`
3. Check the [Issues](https://github.com/belmont-bhagat/substitute-teacher/issues) page
4. Create a new issue with detailed information

## 🔧 Troubleshooting

### Common Issues

**Port already in use**:
```bash
# Kill process using port 8080
lsof -t -i:8080 | xargs -r kill -9

# Kill process using port 5173
lsof -t -i:5173 | xargs -r kill -9
```

**MongoDB connection failed**:
```bash
# Check MongoDB status
docker ps | grep mongo

# Restart MongoDB
docker restart mongodb-simple-login
```

**Java version issues**:
```bash
# Set correct Java version
export JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"
```

**Frontend build errors**:
```bash
# Clean and reinstall
cd simple-login-frontend
rm -rf node_modules package-lock.json
npm install
```

### Debug Mode

**Backend debugging**:
```bash
# Enable debug logging
export LOG_LEVEL=DEBUG
cd simple-login-backend
./mvnw spring-boot:run
```

**Frontend debugging**:
```bash
# Start with debug mode
cd simple-login-frontend
npm run dev
# Check browser developer tools
```

---

**Happy Learning! 🎓**

*This project demonstrates modern full-stack development practices and serves as a comprehensive learning resource.*

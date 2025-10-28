# Simple Login Backend (No Dashboard Branch)

Spring Boot backend application providing JWT-based authentication and user management APIs. In this branch, the frontend consumes only `/api/login` and `/api/profile`.

## 🏗️ Technology Stack

- **Framework**: Spring Boot 3.1.5
- **Java Version**: 17
- **Database**: MongoDB
- **Authentication**: JWT (JSON Web Tokens)
- **Security**: Spring Security Crypto (BCrypt)
- **Build Tool**: Maven

## 🚀 Quick Start

### Prerequisites

- Java 17 or higher
- Maven (included via Maven Wrapper)
- MongoDB (via Docker)

### Running the Application

1. **Set Java 17 environment**
   ```bash
   export JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home
   ```

2. **Start MongoDB**
   ```bash
   docker-compose up -d mongodb
   ```

3. **Run the application**
   ```bash
   ./mvnw spring-boot:run \
     -Dspring-boot.run.jvmArguments="-Dspring.data.mongodb.uri=mongodb://localhost:27017/simple_login -Dauth.jwt.secret=0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
   ```

The application will start on `http://localhost:8080`

## 📁 Project Structure

```
src/main/java/com/example/simpleloginbackend/
├── config/
│   ├── DataSeeder.java          # Database seeding
│   └── JwtConfig.java           # JWT configuration
├── controller/
│   └── AuthController.java      # REST API endpoints
├── model/
│   ├── LoginRequest.java        # Login request DTO
│   └── UserDocument.java        # MongoDB user document
├── repository/
│   └── UserRepository.java      # MongoDB repository
├── service/
│   ├── AuthService.java         # Authentication logic
│   └── JwtService.java          # JWT token handling
└── SimpleLoginBackendApplication.java  # Main application class
```

## 🔧 Configuration

### Application Properties

Key configuration in `src/main/resources/application.properties`:

```properties
# Server Configuration
server.port=8080

# MongoDB Configuration
spring.data.mongodb.uri=mongodb://localhost:27017/simple_login

# JWT Configuration (>= 64 characters recommended)
auth.jwt.secret=0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ
auth.jwt.ttlSeconds=3600
```

### Environment Variables

- `MONGO_URI`: MongoDB connection string
- `AUTH_JWT_SECRET`: JWT signing secret
- `AUTH_JWT_TTL_SECONDS`: JWT token time-to-live

## 🧪 API Endpoints

### Authentication (used by frontend in this branch)

#### Login
- **POST** `/api/login`
- **Body**: `{"username": "admin", "password": "password"}`
- **Response**: `{"token": "jwt-token"}`

#### Profile
- **GET** `/api/profile`
- **Headers**: `Authorization: Bearer <token>`
- **Response**: `{"username": "admin", "role": "instructor"}`

#### List Users
- **GET** `/api/users`
- **Headers**: `Authorization: Bearer <token>`
- **Response**: `{"users": [...], "count": 11}`

## 🔒 Security Features

### JWT Authentication
- Tokens are signed with HMAC SHA-256
- Default expiration: 1 hour
- Bearer token authentication

### Password Security
- Passwords are hashed using BCrypt
- Salt rounds: 10 (configurable)

### CORS Configuration
- Allows all origins (`*`) for development
- Configured in `AuthController`

## 🗄️ Database Schema

### User Document
```java
{
  "username": "admin",
  "passwordHash": "$2a$10$...",  // BCrypt hash
  "role": "instructor"
}
```

### Seeded Data
The application automatically seeds the database with:
- 1 admin user (`admin` / `password`)
- 10 student users (`student1` to `student10`)

## 🛠️ Development

### Building
```bash
./mvnw clean compile
```

### Testing
```bash
./mvnw test
```

### Running Tests
```bash
./mvnw spring-boot:run
```

### Docker Support
```bash
# Build Docker image
docker build -t simple-login-backend .

# Run with Docker Compose
docker-compose up backend
```

## 📊 Logging

Logging is configured to show:
- Application startup information
- MongoDB connection status
- Request/response details (in debug mode)

To enable debug logging:
```properties
logging.level.com.example.simpleloginbackend=DEBUG
```

## 🔧 Troubleshooting

### Common Issues

1. **Java Version Error**
   - Ensure Java 17 is installed and JAVA_HOME is set
   - Check: `java -version`

2. **MongoDB Connection Failed**
   - Ensure MongoDB is running: `docker ps | grep mongodb`
   - Check connection string in application.properties

3. **JWT Token Issues**
   - Verify JWT secret is set
   - Check token expiration time

4. **CORS Errors**
   - Ensure CORS is configured for your frontend URL
   - Check browser developer tools for CORS errors

### Debug Mode

Enable debug logging to troubleshoot issues:
```bash
./mvnw spring-boot:run -Dlogging.level.com.example.simpleloginbackend=DEBUG
```

## 📚 Dependencies

Key dependencies in `pom.xml`:

- `spring-boot-starter-web`: Web framework
- `spring-boot-starter-data-mongodb`: MongoDB integration
- `spring-security-crypto`: Password hashing
- `jjwt`: JWT token handling
- `lombok`: Reduces boilerplate code
- `spring-boot-starter-test`: Testing framework

## 🎯 Learning Objectives

This backend demonstrates:

1. **Spring Boot Basics**
   - Auto-configuration
   - Dependency injection
   - Configuration management

2. **REST API Development**
   - Controller design
   - Request/response handling
   - Error handling

3. **Database Integration**
   - MongoDB with Spring Data
   - Repository pattern
   - Data seeding

4. **Security Implementation**
   - JWT authentication
   - Password hashing
   - CORS configuration

5. **Testing**
   - Unit tests
   - Integration tests
   - Test data setup

---

**Perfect for teaching Spring Boot, REST APIs, and authentication concepts!**
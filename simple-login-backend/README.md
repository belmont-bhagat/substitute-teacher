# Simple Login Backend (No Dashboard Branch)

Spring Boot backend application providing JWT-based authentication and user management APIs. In this branch, the frontend primarily uses `/api/login`, `/api/profile`, and `/api/users` endpoints.

## 🏗️ Technology Stack

- **Framework**: Spring Boot 3.1.5
- **Java Version**: 21 LTS
- **Database**: MongoDB
- **Authentication**: JWT (JSON Web Tokens)
- **Security**: Spring Security Crypto (BCrypt)
- **Build Tool**: Maven

## 🚀 Quick Start

### Prerequisites

- Java 21 LTS or higher
- Maven Wrapper (included - `mvnw` script, no separate Maven installation needed)
- MongoDB (via Docker)

### Running the Application

1. **Ensure JAVA_HOME is properly set to Java 21**
   ```bash
   # Example for macOS/Homebrew
   export JAVA_HOME=/opt/homebrew/opt/openjdk@21
   ```

2. **Start MongoDB**
   ```bash
   docker compose up -d mongodb
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
│   ├── JwtConfig.java           # JWT configuration
│   ├── SecurityConfig.java      # Security configuration
│   └── CorsConfig.java          # CORS configuration
├── controller/
│   ├── AuthController.java      # Authentication & user endpoints
│   └── AdminController.java     # Admin-only endpoints
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

# Allow bean definition overriding (for CORS configuration)
spring.main.allow-bean-definition-overriding=true

# MongoDB Configuration
spring.data.mongodb.uri=mongodb://localhost:27017/simple_login

# JWT Configuration (>= 64 characters recommended)
auth.jwt.secret=default-jwt-secret-change-me-in-production-min-64-chars-required
auth.jwt.ttlSeconds=3600
```

> **Note:** Bean definition overriding is enabled to allow both `CorsConfig` and `SecurityConfig` to define CORS configurations without conflicts.

### Environment Variables

The application reads configuration from `application.properties` which supports environment variable substitution:

- `MONGO_URI` (env var) → `spring.data.mongodb.uri` (property key)
- `AUTH_JWT_SECRET` (env var) → `auth.jwt.secret` (property key)  
- `AUTH_JWT_TTL_SECONDS` (env var) → `auth.jwt.ttlSeconds` (property key)

**Example:** `spring.data.mongodb.uri=${MONGO_URI:mongodb://localhost:27017/simple_login}`
- If `MONGO_URI` environment variable is set, it uses that value
- Otherwise, it uses the default: `mongodb://localhost:27017/simple_login`

## 🧪 API Endpoints

### Public Endpoints

#### Login
- **POST** `/api/login`
- **Body**: `{"username": "admin", "password": "password"}`
- **Response**: `{"token": "jwt-token"}`

### Protected Endpoints (Used by Frontend)

#### Profile
- **GET** `/api/profile`
- **Headers**: `Authorization: Bearer <token>`
- **Response**: `{"username": "admin", "role": "instructor"}`

#### List Users
- **GET** `/api/users`
- **Headers**: `Authorization: Bearer <token>`
- **Response**: `{"users": [...], "count": 11}`

### Admin Endpoints (Available but not used by frontend in no-dashboard branch)

#### Admin User List
- **GET** `/api/admin/users`
- **Headers**: `Authorization: Bearer <token>`
- **Query Params**: `page`, `size`, `query`
- **Response**: Paginated user list

#### Dashboard Stats
- **GET** `/api/admin/stats`
- **Headers**: `Authorization: Bearer <token>`
- **Response**: Dashboard statistics

## 🔒 Security Features

### JWT Authentication
- Tokens are signed with HMAC SHA-256
- Default expiration: 1 hour
- Bearer token authentication

### Password Security
- Passwords are hashed using BCrypt
- Salt rounds: 10 (configurable)

### CORS Configuration
- Allows specific origins for security: `http://localhost:5173`, `http://localhost:3000`, `http://127.0.0.1:5173`
- Configured in `application.properties` and enforced by Spring Security

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
The application automatically seeds the database with **11 total users**:
- 1 admin user: `admin` / `password` (role: instructor)
- 10 student users: `student1` through `student10` / `password` (role: student)

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
docker compose up backend
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
   - Ensure Java 21 LTS is installed and JAVA_HOME is properly set
   - Check: `java -version`
   - Set JAVA_HOME: `export JAVA_HOME=/opt/homebrew/opt/openjdk@21` (macOS/Homebrew)

2. **Bean Definition Override Error**
   - Error: `The bean 'corsConfigurationSource'... could not be registered`
   - Solution: Already fixed in `application.properties` with `spring.main.allow-bean-definition-overriding=true`
   - This allows both SecurityConfig and CorsConfig to define CORS beans

3. **MongoDB Connection Failed**
   - Ensure MongoDB is running: `docker ps | grep mongodb`
   - Check connection string in application.properties

4. **JWT Token Issues**
   - Verify JWT secret is set
   - Check token expiration time

5. **CORS Errors**
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
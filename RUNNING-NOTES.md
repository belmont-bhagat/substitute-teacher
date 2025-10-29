# Running the Application - Quick Reference

## Prerequisites Verified ✅
- Java 21 LTS (OpenJDK 21.0.9)
- Node.js 18+
- Docker & Docker Compose
- MongoDB (via Docker)

## Start Services (In Order)

### 1. Start MongoDB
```bash
docker compose up -d mongodb
```
Verify: `docker ps | grep mongodb`
Container name: `mongodb-simple-login`

### 2. Start Backend
```bash
cd simple-login-backend
export JAVA_HOME=/opt/homebrew/opt/openjdk@21
export PATH="$JAVA_HOME/bin:$PATH"
./mvnw spring-boot:run
```
Or using JAR:
```bash
./mvnw clean package -DskipTests
java -jar target/simple-login-backend-0.0.1-SNAPSHOT.jar
```

### 3. Start Frontend
```bash
cd simple-login-frontend
npm run dev
```

## Access Links

- **Frontend**: http://localhost:5173
- **Backend API**: http://localhost:8080/api
- **MongoDB**: mongodb://localhost:27017/simple_login

## Default Credentials

- **Username**: `admin`
- **Password**: `password`

## Known Configuration

### Bean Override Issue (FIXED)
The application requires `spring.main.allow-bean-definition-overriding=true` in `application.properties` to handle CORS configuration from both `SecurityConfig` and `CorsConfig` classes.

This is already configured in the project.

### JWT Secret
Default secret is 65 characters (meets minimum 64-char requirement):
`default-jwt-secret-change-me-in-production-min-64-chars-required`

## Stop Services

```bash
# Stop backend
pkill -f "spring-boot:run"
# or
pkill -f "simple-login-backend"

# Stop frontend
pkill -f "vite"

# Stop MongoDB
docker compose down mongodb
```

## Quick Test

```bash
# Test login endpoint
curl -X POST http://localhost:8080/api/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"password"}'
```

Should return a JWT token.

## Troubleshooting

See main README.md troubleshooting section for detailed solutions.


# simple-login-backend (Spring Boot)

A minimal Spring Boot API providing:
- `POST /api/login` – verifies credentials against MongoDB; returns JWT
- `GET /api/profile` – requires `Authorization: Bearer <jwt>`; returns profile

## Requirements
- Java 17+
- MongoDB (Docker or local)

## Quick Start
```bash
# 1) Ensure Mongo is running
# Docker:
docker run -d --name mongo -p 27017:27017 mongo:7

# 2) Start the backend (Java 17)
cd simple-login-backend
export JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"
export AUTH_JWT_SECRET='change-me-to-a-long-random-string'
./mvnw spring-boot:run
```
- Seeds Mongo with user `admin/password` on first run.
- App runs at http://localhost:8080

## Packaging
```bash
./mvnw clean package
java -jar target/simple-login-backend-0.0.1-SNAPSHOT.jar
```

## Configuration (application.properties)
- `server.port=8080`
- `spring.data.mongodb.uri=${MONGO_URI:mongodb://localhost:27017/simple_login}`
- `auth.jwt.secret=${AUTH_JWT_SECRET:change-me-change-me-change-me-change-me}`
- `auth.jwt.ttlSeconds=${AUTH_JWT_TTL_SECONDS:3600}`

Override via env vars:
```bash
export MONGO_URI='mongodb://localhost:27017/simple_login'
export AUTH_JWT_SECRET='your-64+chars-secret'
export AUTH_JWT_TTL_SECONDS=7200
```

## Endpoints
- Login
```bash
curl -X POST http://localhost:8080/api/login \
  -H 'Content-Type: application/json' \
  -d '{"username":"admin","password":"password"}'
# { "token": "<jwt>" }
```
- Profile
```bash
curl http://localhost:8080/api/profile \
  -H 'Authorization: Bearer <jwt>'
# { "username": "admin", "role": "instructor" }
```

## Notes
- CORS enabled for all origins (for local dev convenience).
- For production, configure proper secrets, TLS, and CORS restrictions.


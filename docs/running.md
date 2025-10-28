# How to Run Locally (No Dashboard Branch)

1) Start MongoDB (Docker)
```bash
docker compose up -d mongodb
```

2) Start Backend (Java 17)
```bash
cd simple-login-backend
export JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home
./mvnw spring-boot:run \
  -Dspring-boot.run.jvmArguments="-Dspring.data.mongodb.uri=mongodb://localhost:27017/simple_login -Dauth.jwt.secret=0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
```

3) Start Frontend (Vite)
```bash
cd simple-login-frontend
npm install
npm run dev
```

4) Access
- Frontend: http://localhost:5173
- Backend: http://localhost:8080

Default credentials: admin / password


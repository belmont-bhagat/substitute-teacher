# Simple Login Demo (Full Stack)

A minimal full-stack app demonstrating a simple login flow using:
- Backend: Spring Boot (Java 17), MongoDB, JWT
- Frontend: React + TypeScript + Vite + TailwindCSS

## Repos/Apps
- `simple-login-backend/` – Spring Boot API: `/api/login`, `/api/profile`
- `simple-login-frontend/` – Vite dev app (proxy to backend)
- `mongo-auth-service/` – Optional Node/Express service for Mongo credential checks (not required when using the backend’s Mongo integration)

## Prerequisites
- Java 17 (backend)
- Node.js 18+ (frontend)
- Docker Desktop (for MongoDB) or local MongoDB

## Services & Ports
- Backend API: http://localhost:8080
- Frontend app: http://localhost:5173
- MongoDB: mongodb://localhost:27017/simple_login

## Quickstart

1) Start MongoDB (Docker):
```bash
docker run -d --name mongo -p 27017:27017 mongo:7
```

2) Start backend (Java 17 + JWT):
```bash
cd simple-login-backend
export JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"
export AUTH_JWT_SECRET='change-me-to-a-long-random-string'
./mvnw spring-boot:run
```
Backend will seed user `admin/password` on first run.

3) Start frontend:
```bash
cd ../simple-login-frontend
npm install
npm run dev
```
Visit http://localhost:5173

## End-to-end flow
- Login with `admin/password` → backend verifies against MongoDB → returns JWT
- Frontend stores token and calls `/api/profile` with `Authorization: Bearer <token>`

## Environment
- Backend reads:
  - `MONGO_URI` (default `mongodb://localhost:27017/simple_login`)
  - `AUTH_JWT_SECRET` (required in production; default dev value present)
  - `AUTH_JWT_TTL_SECONDS` (default 3600)
- Frontend dev proxy forwards `/api/*` to `http://localhost:8080`.

## Troubleshooting
- Docker not running:
  - Start Docker Desktop, then run the `docker run` command above.
- Java not found / wrong version:
  - Ensure Java 17 is active; set `JAVA_HOME` as shown above.
- Port conflicts:
  - Change ports in `simple-login-frontend/vite.config.ts` (dev server) or `simple-login-backend/src/main/resources/application.properties` (backend).
- Mongo connection issues:
  - Confirm `docker ps` shows a `mongo` container and `nc -vz localhost 27017` succeeds.

## Optional: Node/Express Mongo microservice
If you prefer a separate microservice for credential checking, see `mongo-auth-service/README.md`.

# Architecture (No Dashboard Branch)

- Backend: Spring Boot 3, Java 17, MongoDB
- Frontend: React 18 + TypeScript + Vite
- Auth: JWT (HMAC-SHA256)

Flow:
1. Client posts credentials to `/api/login`
2. Backend validates credentials (Mongo), issues JWT
3. Client stores token, calls `/api/profile` with `Authorization: Bearer <token>`

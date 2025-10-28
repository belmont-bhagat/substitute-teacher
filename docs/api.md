# API Reference (No Dashboard Branch)

Base URL: http://localhost:8080/api

## POST /login
- Body: `{ "username": "admin", "password": "password" }`
- 200: `{ "token": "..." }`
- 401: `{ "error": "Invalid credentials" }`

## GET /profile
- Headers: `Authorization: Bearer <token>`
- 200: `{ "username": "admin", "role": "instructor" }`
- 401: `{ "error": "Unauthorized" }`

# API Reference (No Dashboard Branch)

**Base URL**: `http://localhost:8080/api`

## Public Endpoints

### POST /login
Authenticate a user and receive a JWT token.

**Request:**
```json
{
  "username": "admin",
  "password": "password"
}
```

**Response (200 OK):**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
}
```

**Response (401 Unauthorized):**
```json
{
  "error": "Invalid credentials"
}
```

## Protected Endpoints

### GET /profile
Get the current user's profile information.

**Headers:**
```
Authorization: Bearer <token>
```

**Response (200 OK):**
```json
{
  "username": "admin",
  "role": "instructor"
}
```

**Response (401 Unauthorized):**
```json
{
  "error": "Unauthorized"
}
```

### GET /users
Get a list of all users (admin only).

**Headers:**
```
Authorization: Bearer <token>
```

**Response (200 OK):**
```json
{
  "users": [
    {"username": "admin", "role": "instructor"},
    {"username": "student1", "role": "student"}
  ],
  "count": 11
}
```

## Admin Endpoints (Available but not used in frontend)

### GET /admin/users
Get paginated list of users with search capability.

### GET /admin/stats
Get dashboard statistics.

> **Note**: These admin endpoints exist in the backend but are not consumed by the no-dashboard branch frontend.

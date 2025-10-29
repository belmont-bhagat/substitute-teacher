# Architecture (No Dashboard Branch)

## Technology Stack

- **Backend**: Spring Boot 3.1.5, Java 21 LTS, MongoDB
- **Frontend**: React 18 + TypeScript + Vite
- **Authentication**: JWT (HMAC-SHA256)
- **Database**: MongoDB (Docker)

## Configuration Notes

- Bean definition overriding is enabled to support multiple CORS configurations
- Default JWT secret is 65+ characters (meets security requirements)
- MongoDB connection string supports environment variable override

## Authentication Flow

1. Client posts credentials to `/api/login`
2. Backend validates credentials against MongoDB, issues JWT token
3. Client stores token in localStorage
4. Client calls `/api/profile` with `Authorization: Bearer <token>` header
5. Backend validates token and returns user profile

## API Endpoints (No Dashboard Branch)

### Public Endpoints
- `POST /api/login` - Authenticate user and receive JWT token

### Protected Endpoints (Requires JWT)
- `GET /api/profile` - Get current user profile
- `GET /api/users` - List all users (admin only)

### Admin Endpoints (Backend only - not used in this branch's frontend)
- `GET /api/admin/users` - Get paginated user list
- `GET /api/admin/stats` - Get dashboard statistics

# Overview (No Dashboard Branch)

This branch provides a **minimal authentication flow** for educational purposes.

## What's Included

### Frontend Features
- ✅ Login page with form validation
- ✅ Profile page showing user information
- ✅ JWT token management
- ✅ Protected route handling
- ❌ **Removed**: Dashboard routes and pages

### Backend Features
- ✅ User authentication with JWT
- ✅ Password hashing with BCrypt
- ✅ MongoDB integration
- ✅ CORS configuration
- ✅ Admin endpoints (available but not used by frontend)

### API Endpoints
- `POST /api/login` - User authentication
- `GET /api/profile` - User profile (protected)
- `GET /api/users` - List all users (admin only)

## Technology Stack
- **Backend**: Spring Boot 3.1.5, Java 21 LTS, MongoDB
- **Frontend**: React 18 + TypeScript + Vite
- **Database**: MongoDB (Docker)
- **Authentication**: JWT tokens

## Quick Start
See [running.md](./running.md) for setup instructions.

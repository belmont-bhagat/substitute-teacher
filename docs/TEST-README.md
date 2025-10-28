# Simple Login Application - Integration Tests

This directory contains comprehensive integration tests to verify that the frontend and backend are properly connected and all APIs are working correctly.

## 🚀 Quick Start

### Prerequisites
- Backend running on `http://localhost:8080`
- Frontend running on `http://localhost:5173`
- MongoDB running (via Docker Compose)

### Running Tests

#### Option 1: HTML Test Interface (Recommended)
1. Open `test-integration.html` in your browser
2. Click "Run Quick Test" for a fast validation
3. Click "Run Detailed Test" for comprehensive testing
4. View real-time results and service status

#### Option 2: Bash Script
```bash
./test-integration.sh
```

#### Option 3: Node.js Script
```bash
npm install axios
node test-integration.js
```

## 📋 Test Coverage

The integration tests verify:

### ✅ Backend Health
- Spring Boot application is running
- API endpoints are accessible
- Database connection is working

### ✅ Authentication Flow
- Admin login (`admin` / `password`)
- User login (`user` / `password`)
- JWT token generation and validation
- Role-based access control

### ✅ API Endpoints
- `POST /api/auth/login` - User authentication
- `GET /api/auth/profile` - User profile retrieval
- `GET /api/admin/stats` - Dashboard statistics (Admin only)
- `GET /api/admin/users` - User management (Admin only)
- `PATCH /api/admin/users/{id}` - User updates (Admin only)

### ✅ Security Features
- Invalid credentials rejection
- Role-based endpoint protection
- CORS configuration
- Token expiration handling

### ✅ Frontend Integration
- React application accessibility
- Frontend-backend communication
- Error handling and loading states

## 🔧 Test Credentials

| Username | Password | Role | Access Level |
|----------|----------|------|--------------|
| `admin` | `password` | ADMIN | Full dashboard access |
| `user` | `password` | USER | Profile and settings only |
| `testuser1` | `password` | USER | Regular user access |
| `testuser2` | `password` | USER | Regular user access |
| `testuser3` | `password` | USER | Regular user access |
| `testuser4` | `password` | USER | Regular user access |
| `testuser5` | `password` | USER | Regular user access |

## 🎯 Expected Test Results

### Successful Test Run
```
✅ PASS: Backend Health Check - Service is running on http://localhost:8080
✅ PASS: Frontend Health Check - Service is running on http://localhost:5173
✅ PASS: Admin Login - Successfully logged in as admin
✅ PASS: User Login - Successfully logged in as regular user
✅ PASS: Admin Profile - Admin profile retrieved with correct role
✅ PASS: User Profile - User profile retrieved with correct role
✅ PASS: Dashboard Stats - Retrieved stats with X total users
✅ PASS: Users List - Retrieved X users with pagination
✅ PASS: User Admin Access - Correctly denied access to admin endpoints
✅ PASS: Invalid Login - Correctly rejected invalid credentials
✅ PASS: Frontend Integration - Frontend is serving the application
✅ PASS: CORS Configuration - CORS headers present
```

## 🐛 Troubleshooting

### Backend Not Running
```bash
cd simple-login-backend
./mvnw spring-boot:run
```

### Frontend Not Running
```bash
cd simple-login-frontend
npm run dev
```

### MongoDB Not Running
```bash
docker-compose up -d mongodb
```

### Port Conflicts
- Backend: Change port in `application.properties`
- Frontend: Change port in `vite.config.ts`
- Update test configuration accordingly

## 📊 Test Metrics

The tests validate:
- **12 different scenarios** covering all major functionality
- **Role-based access control** (ADMIN vs USER)
- **API endpoint security** and validation
- **Frontend-backend integration** and communication
- **Error handling** and edge cases
- **CORS configuration** for cross-origin requests

## 🎓 Educational Value

These tests demonstrate:
- **Integration testing** best practices
- **API testing** methodologies
- **Authentication flow** validation
- **Role-based security** implementation
- **Frontend-backend communication** patterns
- **Error handling** and user feedback

## 🔄 Continuous Testing

For development, you can:
1. Run tests after each code change
2. Use the HTML interface for quick validation
3. Integrate with CI/CD pipelines using the Node.js script
4. Monitor service health in real-time

## 📝 Test Customization

You can modify the tests by:
- Updating `CONFIG` object in test files
- Adding new test scenarios
- Changing test credentials
- Adjusting timeout values
- Adding custom assertions

---

**Ready for your teaching class!** 🎉

The integration tests ensure your Simple Login application is working correctly and ready for demonstration to students.

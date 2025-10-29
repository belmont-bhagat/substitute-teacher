# 🧪 Tests

**Integration tests and testing documentation**

## 📋 Test Files

### Integration Tests (`integration/`)
- **test-integration.html** - HTML-based test interface (recommended)
- **test-integration.js** - Node.js test script
- **test-integration.sh** - Bash test script
- **student-reference.html** - Reference guide for students

---

## 🚀 Running Tests

### Prerequisites
- Backend running on `http://localhost:8080`
- Frontend running on `http://localhost:5173`
- MongoDB running via Docker

### Option 1: HTML Test Interface (Easiest)
1. Start all services (backend, frontend, MongoDB)
2. Open `integration/test-integration.html` in your browser
3. Click "Run Quick Test" or "Run Detailed Test"
4. View results in the browser

### Option 2: Command Line (Node.js)
```bash
cd tests/integration
node test-integration.js
```

### Option 3: Bash Script
```bash
cd tests/integration
chmod +x test-integration.sh
./test-integration.sh
```

---

## ✅ What Tests Cover

### Authentication Flow
- ✅ User login with valid credentials
- ✅ User login with invalid credentials
- ✅ JWT token generation
- ✅ Token validation

### API Endpoints
- ✅ POST `/api/login` - Authentication
- ✅ GET `/api/profile` - User profile (protected)
- ✅ GET `/api/users` - List users (protected)

### Error Handling
- ✅ Invalid credentials rejection
- ✅ Missing token handling
- ✅ Expired token handling

---

## 📖 Test Documentation

See [TEST-README.md](./TEST-README.md) for comprehensive testing documentation.

---

## 🐛 Troubleshooting Tests

### Tests fail with "Connection refused"
**Problem**: Services not running  
**Solution**: Start backend, frontend, and MongoDB first

### Tests fail with "Unauthorized"
**Problem**: Backend authentication issue  
**Solution**: Check backend logs, verify MongoDB is seeded with users

### Browser tests don't load
**Problem**: CORS or network issue  
**Solution**: Ensure backend CORS allows `localhost:5173`

---

## 📝 Test Credentials

- **Admin**: `admin` / `password`
- **Student**: `student1` / `password` (through `student10`)

---

**Happy Testing!** ✅


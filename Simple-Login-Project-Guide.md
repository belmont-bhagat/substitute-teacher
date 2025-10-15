# Simple Login Application - Complete Student Guide

## Table of Contents

1. [Project Overview](#project-overview)
2. [Architecture Overview](#architecture-overview)
3. [Technology Stack](#technology-stack)
4. [Project Structure](#project-structure)
5. [Backend Implementation](#backend-implementation)
6. [Frontend Implementation](#frontend-implementation)
7. [Database Integration](#database-integration)
8. [Authentication & Security](#authentication--security)
9. [API Documentation](#api-documentation)
10. [User Dashboard](#user-dashboard)
11. [Testing & Quality Assurance](#testing--quality-assurance)
12. [Deployment & Setup](#deployment--setup)
13. [Troubleshooting](#troubleshooting)
14. [Best Practices](#best-practices)
15. [Reference Section](#reference-section)

---

## Project Overview

### What is this Project?

The Simple Login Application is a full-stack web application that demonstrates modern authentication, user management, and dashboard functionality. It serves as a comprehensive learning project that covers:

- **Backend Development**: Spring Boot REST API with MongoDB
- **Frontend Development**: React with TypeScript and modern UI
- **Authentication**: JWT-based security
- **Database**: MongoDB integration
- **User Management**: Role-based access control
- **Dashboard**: Interactive user interface with search and filtering

### Learning Objectives

By completing this project, students will understand:

1. **Full-Stack Development**: How frontend and backend communicate
2. **REST API Design**: Creating and consuming web services
3. **Authentication**: Implementing secure login systems
4. **Database Integration**: Working with NoSQL databases
5. **Modern Frontend**: React hooks, routing, and state management
6. **Security Best Practices**: JWT tokens, password hashing, CORS
7. **Testing**: API testing with Postman
8. **Version Control**: Git workflow and collaboration

### Project Features

- ✅ **User Authentication**: Login with JWT tokens
- ✅ **Role-Based Access**: Instructor and Student roles
- ✅ **User Dashboard**: View and manage all users
- ✅ **Search & Filter**: Find users by name, email, or role
- ✅ **Responsive Design**: Works on desktop and mobile
- ✅ **API Testing**: Complete Postman collection
- ✅ **Database Integration**: MongoDB with user seeding

---

## Architecture Overview

### System Architecture

```
┌─────────────────┐    HTTP/HTTPS    ┌─────────────────┐
│   Frontend      │◄─────────────────┤   Backend       │
│   (React)       │                  │   (Spring Boot)  │
│   Port: 5173    │                  │   Port: 8080    │
└─────────────────┘                  └─────────────────┘
                                              │
                                              │ MongoDB Protocol
                                              ▼
                                     ┌─────────────────┐
                                     │   Database      │
                                     │   (MongoDB)     │
                                     │   Port: 27017   │
                                     └─────────────────┘
```

### Data Flow

1. **User Login**: Frontend sends credentials → Backend validates → Returns JWT
2. **API Requests**: Frontend includes JWT in headers → Backend validates → Returns data
3. **User Dashboard**: Frontend requests user list → Backend queries MongoDB → Returns formatted data
4. **Search/Filter**: Frontend filters data client-side for responsive UI

### Security Flow

```
User Login → Password Verification → JWT Generation → Token Storage → API Authentication
```

---

## Technology Stack

### Backend Technologies

| Technology | Version | Purpose |
|------------|---------|---------|
| **Java** | 17+ | Programming language |
| **Spring Boot** | 3.1.5 | Framework for REST APIs |
| **Spring Data MongoDB** | - | Database integration |
| **Maven** | - | Build and dependency management |
| **Lombok** | - | Reduces boilerplate code |
| **JJWT** | 0.11.5 | JWT token handling |
| **MongoDB** | Latest | NoSQL database |

### Frontend Technologies

| Technology | Version | Purpose |
|------------|---------|---------|
| **React** | 18.2.0 | UI framework |
| **TypeScript** | 5.9.3 | Type-safe JavaScript |
| **Vite** | 7.1.7 | Build tool and dev server |
| **React Router DOM** | 6.22.3 | Client-side routing |
| **Axios** | 1.12.2 | HTTP client for API calls |
| **TailwindCSS** | 4.1.14 | Utility-first CSS framework |

### Development Tools

| Tool | Purpose |
|------|---------|
| **Postman** | API testing and documentation |
| **Git** | Version control |
| **Docker** | MongoDB containerization |
| **VS Code** | Code editor |

---

## Project Structure

### Directory Layout

```
substitute-teacher/
├── simple-login-backend/          # Spring Boot backend
│   ├── src/main/java/com/example/simpleloginbackend/
│   │   ├── SimpleLoginBackendApplication.java
│   │   ├── controller/
│   │   │   └── AuthController.java
│   │   ├── model/
│   │   │   ├── LoginRequest.java
│   │   │   └── UserDocument.java
│   │   ├── repository/
│   │   │   └── UserRepository.java
│   │   ├── service/
│   │   │   ├── AuthService.java
│   │   │   └── JwtService.java
│   │   ├── config/
│   │   │   ├── JwtConfig.java
│   │   │   └── DataSeeder.java
│   │   └── resources/
│   │       └── application.properties
│   └── pom.xml
├── simple-login-frontend/         # React frontend
│   ├── src/
│   │   ├── components/
│   │   │   ├── AuthLayout.tsx
│   │   │   ├── Button.tsx
│   │   │   ├── Card.tsx
│   │   │   └── Input.tsx
│   │   ├── pages/
│   │   │   ├── LoginPage.tsx
│   │   │   ├── ProfilePage.tsx
│   │   │   └── UsersDashboard.tsx
│   │   ├── lib/
│   │   │   ├── auth.ts
│   │   │   └── api.ts
│   │   ├── main.tsx
│   │   └── index.css
│   ├── package.json
│   └── vite.config.ts
├── postman/                       # API testing
│   └── Simple-Login.postman_collection.json
└── README.md
```

### Key Files Explained

#### Backend Files
- **`AuthController.java`**: Handles all API endpoints
- **`UserDocument.java`**: MongoDB document model
- **`AuthService.java`**: Business logic for authentication
- **`JwtService.java`**: JWT token generation and validation
- **`DataSeeder.java`**: Seeds initial users into database

#### Frontend Files
- **`main.tsx`**: Application entry point with routing
- **`LoginPage.tsx`**: User login interface
- **`ProfilePage.tsx`**: User profile display
- **`UsersDashboard.tsx`**: User management dashboard
- **`api.ts`**: Axios configuration for API calls
- **`auth.ts`**: Token management utilities

---

## Backend Implementation

### Spring Boot Configuration

#### Application Properties (`application.properties`)

```properties
# Server Configuration
server.port=8080
spring.application.name=simple-login-backend

# MongoDB Configuration
spring.data.mongodb.uri=${MONGO_URI:mongodb://localhost:27017/simple_login}

# JWT Configuration
auth.jwt.secret=${AUTH_JWT_SECRET:a-very-long-and-secure-secret-key-for-jwt-signing-and-verification-at-least-64-characters-long}
auth.jwt.expiration-ms=3600000 # 1 hour

# Logging Configuration
logging.level.com.example.simpleloginbackend=INFO
```

#### Maven Dependencies (`pom.xml`)

```xml
<dependencies>
    <!-- Spring Boot Starters -->
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-data-mongodb</artifactId>
    </dependency>
    <dependency>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-devtools</artifactId>
    </dependency>
    
    <!-- JWT Dependencies -->
    <dependency>
        <groupId>io.jsonwebtoken</groupId>
        <artifactId>jjwt-api</artifactId>
        <version>0.11.5</version>
    </dependency>
    <dependency>
        <groupId>io.jsonwebtoken</groupId>
        <artifactId>jjwt-impl</artifactId>
        <version>0.11.5</version>
        <scope>runtime</scope>
    </dependency>
    
    <!-- Utilities -->
    <dependency>
        <groupId>org.projectlombok</groupId>
        <artifactId>lombok</artifactId>
    </dependency>
</dependencies>
```

### Data Models

#### User Document (`UserDocument.java`)

```java
@Data
@Document(collection = "users")
public class UserDocument {
    @Id
    private String id;
    private String username;
    private String passwordHash;
    private String role;
    private String email;
}
```

#### Login Request (`LoginRequest.java`)

```java
@Data
public class LoginRequest {
    private String username;
    private String password;
}
```

### API Endpoints

#### Authentication Controller (`AuthController.java`)

```java
@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
public class AuthController {
    
    // POST /api/login
    @PostMapping("/login")
    public ResponseEntity<Map<String, String>> login(@RequestBody LoginRequest loginRequest) {
        // Validate credentials and return JWT token
    }
    
    // GET /api/profile
    @GetMapping("/profile")
    public ResponseEntity<Map<String, String>> getProfile(
            @RequestHeader(value = "Authorization", required = false) String authHeader) {
        // Validate JWT and return user profile
    }
    
    // GET /api/users
    @GetMapping("/users")
    public ResponseEntity<Map<String, Object>> getAllUsers(
            @RequestHeader(value = "Authorization", required = false) String authHeader) {
        // Return list of all users
    }
}
```

### Service Layer

#### Authentication Service (`AuthService.java`)

```java
@Service
public class AuthService {
    
    public boolean validateCredentials(String username, String rawPassword) {
        // Verify password against stored hash
    }
    
    public Optional<UserDocument> getUser(String username) {
        // Find user by username
    }
    
    public List<UserDocument> getAllUsers() {
        // Return all users from database
    }
}
```

#### JWT Service (`JwtService.java`)

```java
@Service
public class JwtService {
    
    public String generateToken(String username, String role) {
        // Create JWT with user claims
    }
    
    public String validateAndGetSubject(String token) {
        // Validate JWT and extract username
    }
    
    public String extractRole(String token) {
        // Extract role from JWT claims
    }
}
```

### Database Integration

#### Repository Interface (`UserRepository.java`)

```java
public interface UserRepository extends MongoRepository<UserDocument, String> {
    Optional<UserDocument> findByUsername(String username);
}
```

#### Data Seeding (`DataSeeder.java`)

```java
@Configuration
public class DataSeeder {
    
    @Bean
    CommandLineRunner seedUsers(UserRepository userRepository) {
        return args -> {
            // Seed admin user
            // Seed student1 through student10
        };
    }
}
```

---

## Frontend Implementation

### React Application Structure

#### Main Application (`main.tsx`)

```typescript
import React from 'react'
import ReactDOM from 'react-dom/client'
import { createBrowserRouter, RouterProvider } from 'react-router-dom'
import './index.css'
import LoginPage from './pages/LoginPage'
import ProfilePage from './pages/ProfilePage'
import UsersDashboard from './pages/UsersDashboard'

const router = createBrowserRouter([
  { path: '/', element: <LoginPage /> },
  { path: '/login', element: <LoginPage /> },
  { path: '/profile', element: <ProfilePage /> },
  { path: '/dashboard/users', element: <UsersDashboard /> },
])

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <RouterProvider router={router} />
  </React.StrictMode>,
)
```

### API Integration

#### Axios Configuration (`api.ts`)

```typescript
import axios from 'axios';
import { getToken, clearToken } from './auth';

const API_BASE_URL = import.meta.env.VITE_API_BASE_URL || '/api';

const api = axios.create({
  baseURL: API_BASE_URL,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Request interceptor to add JWT token
api.interceptors.request.use(
  (config) => {
    const token = getToken();
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => Promise.reject(error)
);

// Response interceptor to handle 401 errors
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response && error.response.status === 401) {
      clearToken();
    }
    return Promise.reject(error);
  }
);

export default api;
```

#### Authentication Utilities (`auth.ts`)

```typescript
const TOKEN_KEY = 'jwt_token';

export const getToken = (): string | null => {
  return localStorage.getItem(TOKEN_KEY);
};

export const setToken = (token: string): void => {
  localStorage.setItem(TOKEN_KEY, token);
};

export const clearToken = (): void => {
  localStorage.removeItem(TOKEN_KEY);
};
```

### Page Components

#### Login Page (`LoginPage.tsx`)

```typescript
export default function LoginPage() {
  const navigate = useNavigate()
  const [username, setUsername] = useState('')
  const [password, setPassword] = useState('')
  const [error, setError] = useState<string | null>(null)

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault()
    try {
      const res = await api.post('/login', { username, password })
      setToken(res.data.token)
      navigate('/profile')
    } catch (err: any) {
      setError(err?.response?.data?.error || 'Invalid credentials')
    }
  }

  return (
    <AuthLayout>
      <Card>
        <CardHeader title="Sign in" />
        <CardBody>
          <form onSubmit={handleSubmit}>
            {/* Form fields */}
          </form>
        </CardBody>
      </Card>
    </AuthLayout>
  )
}
```

#### Users Dashboard (`UsersDashboard.tsx`)

```typescript
export default function UsersDashboard() {
  const [users, setUsers] = useState<User[]>([])
  const [searchTerm, setSearchTerm] = useState('')
  const [filterRole, setFilterRole] = useState('All Roles')

  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const response = await api.get('/users')
        setUsers(response.data.users)
      } catch (err) {
        // Handle error
      }
    }
    fetchUsers()
  }, [])

  const filteredUsers = users.filter(user => {
    const matchesSearch = user.username.toLowerCase().includes(searchTerm.toLowerCase())
    const matchesRole = filterRole === 'All Roles' || user.role === filterRole.toLowerCase()
    return matchesSearch && matchesRole
  })

  return (
    <AuthLayout>
      <Card>
        <CardHeader title="Users Dashboard" />
        <CardBody>
          {/* Search and filter controls */}
          {/* Users table */}
        </CardBody>
      </Card>
    </AuthLayout>
  )
}
```

### UI Components

#### Reusable Components

**Card Component (`Card.tsx`)**
```typescript
export function Card({ children, className = '' }: { children: ReactNode; className?: string }) {
  return (
    <div className={`bg-white border border-gray-200 rounded-xl ${className}`}>
      {children}
    </div>
  )
}
```

**Button Component (`Button.tsx`)**
```typescript
export default function Button({ loading, children, className = '', ...props }: Props) {
  return (
    <button
      className={`w-full inline-flex items-center justify-center gap-2 bg-gray-900 text-white py-2.5 rounded-lg hover:bg-black transition-colors focus:outline-none focus:ring-2 focus:ring-gray-900 disabled:opacity-60 ${className}`}
      disabled={loading || props.disabled}
      {...props}
    >
      {loading && <span className="h-4 w-4 animate-spin rounded-full border-2 border-white/60 border-t-transparent"></span>}
      {loading ? 'Working...' : children}
    </button>
  )
}
```

### Styling with TailwindCSS

#### Global Styles (`index.css`)

```css
@tailwind base;
@tailwind components;
@tailwind utilities;

:root { color-scheme: light; }

html, body, #root { height: 100%; }

body { @apply text-gray-900 bg-white antialiased; }

/* Minimal focus ring */
*:focus-visible { outline: 0; box-shadow: 0 0 0 2px rgba(0,0,0,0.9); border-radius: 4px; }
```

#### TailwindCSS Configuration (`tailwind.config.js`)

```javascript
export default {
  content: [
    './index.html',
    './src/**/*.{js,ts,jsx,tsx}',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
```

---

## Database Integration

### MongoDB Setup

#### Docker Configuration

```bash
# Start MongoDB with Docker
docker run -d --name mongodb -p 27017:27017 mongo:latest
```

#### Database Schema

**Users Collection**
```json
{
  "_id": "ObjectId",
  "username": "string",
  "passwordHash": "string (bcrypt)",
  "role": "string (instructor|student)",
  "email": "string"
}
```

#### Sample Data

**Admin User**
```json
{
  "username": "admin",
  "passwordHash": "$2a$10$...",
  "role": "instructor",
  "email": "admin@example.com"
}
```

**Student Users**
```json
{
  "username": "student1",
  "passwordHash": "$2a$10$...",
  "role": "student",
  "email": "student1@student.example.com"
}
```

### Database Operations

#### Repository Methods

```java
public interface UserRepository extends MongoRepository<UserDocument, String> {
    Optional<UserDocument> findByUsername(String username);
    List<UserDocument> findByRole(String role);
    List<UserDocument> findByEmailContaining(String email);
}
```

#### Service Layer Database Operations

```java
@Service
public class AuthService {
    
    public boolean validateCredentials(String username, String rawPassword) {
        Optional<UserDocument> userOpt = userRepository.findByUsername(username);
        if (userOpt.isEmpty()) return false;
        
        UserDocument user = userOpt.get();
        return BCrypt.checkpw(rawPassword, user.getPasswordHash());
    }
    
    public List<UserDocument> getAllUsers() {
        return userRepository.findAll();
    }
}
```

---

## Authentication & Security

### JWT Implementation

#### Token Structure

```json
{
  "header": {
    "alg": "HS256",
    "typ": "JWT"
  },
  "payload": {
    "sub": "username",
    "role": "instructor|student",
    "iat": 1640995200,
    "exp": 1640998800
  },
  "signature": "HMACSHA256(base64UrlEncode(header) + '.' + base64UrlEncode(payload), secret)"
}
```

#### JWT Service Implementation

```java
@Service
public class JwtService {
    
    public String generateToken(String username, String role) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("role", role);
        
        return Jwts.builder()
                .setClaims(claims)
                .setSubject(username)
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + expirationTime))
                .signWith(secretKey, SignatureAlgorithm.HS256)
                .compact();
    }
    
    public String validateAndGetSubject(String token) {
        try {
            return Jwts.parserBuilder()
                    .setSigningKey(secretKey)
                    .build()
                    .parseClaimsJws(token)
                    .getBody()
                    .getSubject();
        } catch (SecurityException | IllegalArgumentException e) {
            return null;
        }
    }
}
```

### Password Security

#### BCrypt Hashing

```java
// Password hashing
String hashedPassword = BCrypt.hashpw(rawPassword, BCrypt.gensalt());

// Password verification
boolean isValid = BCrypt.checkpw(rawPassword, hashedPassword);
```

#### Security Best Practices

1. **Password Hashing**: Use BCrypt with salt
2. **JWT Expiration**: Set reasonable expiration times
3. **HTTPS**: Use secure connections in production
4. **CORS**: Configure appropriate CORS policies
5. **Input Validation**: Validate all user inputs
6. **Error Handling**: Don't expose sensitive information

### Authentication Flow

```
1. User submits login credentials
2. Backend validates credentials against database
3. If valid, generate JWT token with user claims
4. Return token to frontend
5. Frontend stores token in localStorage
6. Subsequent requests include token in Authorization header
7. Backend validates token on each request
8. If token is valid, process request; if not, return 401
```

---

## API Documentation

### Endpoint Overview

| Method | Endpoint | Description | Authentication |
|--------|----------|-------------|-----------------|
| POST | `/api/login` | User login | None |
| GET | `/api/profile` | Get user profile | JWT Required |
| GET | `/api/users` | List all users | JWT Required |

### Detailed API Documentation

#### POST /api/login

**Description**: Authenticate user and return JWT token

**Request Body**:
```json
{
  "username": "admin",
  "password": "password"
}
```

**Success Response** (200):
```json
{
  "token": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhZG1pbiIsImlhdCI6MTY0MDk5NTIwMCwiZXhwIjoxNjQwOTk4ODAwfQ.signature"
}
```

**Error Response** (401):
```json
{
  "error": "Invalid credentials"
}
```

#### GET /api/profile

**Description**: Get current user's profile information

**Headers**:
```
Authorization: Bearer <jwt_token>
```

**Success Response** (200):
```json
{
  "username": "admin",
  "role": "instructor"
}
```

**Error Response** (401):
```json
{
  "error": "Unauthorized"
}
```

#### GET /api/users

**Description**: Get list of all users in the system

**Headers**:
```
Authorization: Bearer <jwt_token>
```

**Success Response** (200):
```json
{
  "count": 11,
  "users": [
    {
      "id": "68efc1d8bb9e021c29f5408e",
      "username": "admin",
      "email": "admin@example.com",
      "role": "instructor"
    },
    {
      "id": "68f00e34cb34860e47e3e284",
      "username": "student1",
      "email": "student1@student.example.com",
      "role": "student"
    }
  ]
}
```

### Error Handling

#### Common HTTP Status Codes

- **200 OK**: Request successful
- **401 Unauthorized**: Invalid or missing authentication
- **404 Not Found**: Resource not found
- **500 Internal Server Error**: Server error

#### Error Response Format

```json
{
  "error": "Error message description"
}
```

---

## User Dashboard

### Dashboard Features

#### User Interface Components

1. **Header Section**
   - Page title
   - User count display
   - Navigation controls

2. **Search and Filter Section**
   - Text search by username or email
   - Role filter dropdown
   - Real-time filtering

3. **Users Table**
   - User ID display
   - Username with formatting
   - Email address
   - Role badges with color coding
   - Action buttons

4. **Responsive Design**
   - Mobile-friendly layout
   - Collapsible columns on small screens
   - Touch-friendly controls

#### Implementation Details

**State Management**:
```typescript
const [users, setUsers] = useState<User[]>([])
const [searchTerm, setSearchTerm] = useState('')
const [filterRole, setFilterRole] = useState('All Roles')
const [loading, setLoading] = useState(true)
const [error, setError] = useState<string | null>(null)
```

**Data Fetching**:
```typescript
useEffect(() => {
  const fetchUsers = async () => {
    try {
      const response = await api.get('/users')
      setUsers(response.data.users)
    } catch (err: any) {
      setError(err.response?.data?.error || 'Failed to fetch users')
    } finally {
      setLoading(false)
    }
  }
  fetchUsers()
}, [])
```

**Filtering Logic**:
```typescript
const filteredUsers = users.filter(user => {
  const matchesSearch = user.username.toLowerCase().includes(searchTerm.toLowerCase()) ||
                        user.email.toLowerCase().includes(searchTerm.toLowerCase())
  const matchesRole = filterRole === 'All Roles' || user.role === filterRole.toLowerCase()
  return matchesSearch && matchesRole
})
```

### User Roles and Permissions

#### Role Types

1. **Instructor Role**
   - Full access to all features
   - Can view all users
   - Administrative privileges

2. **Student Role**
   - Limited access
   - Can view user dashboard
   - Cannot modify user data

#### Role-Based UI

```typescript
// Role-based styling
<span className={`px-2 inline-flex text-xs leading-5 font-semibold rounded-full ${
  user.role === 'instructor' ? 'bg-blue-100 text-blue-800' : 'bg-green-100 text-green-800'
}`}>
  {user.role}
</span>
```

---

## Testing & Quality Assurance

### Postman Collection

#### Collection Structure

1. **Authentication Tests**
   - Login with admin credentials
   - Login with student credentials
   - Invalid login test

2. **API Endpoint Tests**
   - Profile endpoint with valid token
   - Profile endpoint without token
   - Users list endpoint

3. **Error Handling Tests**
   - Unauthorized access tests
   - Invalid token tests
   - Missing authentication tests

#### Test Scripts

**Login Test Script**:
```javascript
if (pm.response.code === 200) {
  try {
    const data = pm.response.json();
    if (data.token) {
      pm.environment.set('token', data.token);
      pm.test('Token captured', function () { 
        pm.expect(data.token).to.be.a('string'); 
      });
    }
  } catch (e) { /* ignore */ }
}
```

**Users List Test Script**:
```javascript
if (pm.response.code === 200) {
  const data = pm.response.json();
  
  pm.test('Response has count field', function () {
    pm.expect(data).to.have.property('count');
    pm.expect(data.count).to.be.a('number');
  });
  
  pm.test('Response has users array', function () {
    pm.expect(data).to.have.property('users');
    pm.expect(data.users).to.be.an('array');
  });
}
```

### Manual Testing Checklist

#### Frontend Testing

- [ ] Login page loads correctly
- [ ] Login with valid credentials works
- [ ] Login with invalid credentials shows error
- [ ] Profile page displays user information
- [ ] Dashboard loads and displays users
- [ ] Search functionality works
- [ ] Filter by role works
- [ ] Responsive design works on mobile
- [ ] Logout clears token and redirects

#### Backend Testing

- [ ] All API endpoints respond correctly
- [ ] JWT token validation works
- [ ] Password hashing and verification works
- [ ] Database operations work correctly
- [ ] Error handling returns appropriate status codes
- [ ] CORS headers are set correctly

### Performance Considerations

#### Frontend Optimization

1. **Code Splitting**: Lazy load components
2. **Memoization**: Use React.memo for expensive components
3. **Debouncing**: Debounce search input
4. **Caching**: Cache API responses when appropriate

#### Backend Optimization

1. **Database Indexing**: Index frequently queried fields
2. **Connection Pooling**: Optimize database connections
3. **Caching**: Cache frequently accessed data
4. **Pagination**: Implement pagination for large datasets

---

## Deployment & Setup

### Prerequisites

#### System Requirements

- **Java**: JDK 17 or higher
- **Node.js**: Version 18 or higher
- **MongoDB**: Version 5.0 or higher
- **Git**: Latest version
- **Docker**: Optional, for MongoDB containerization

#### Development Tools

- **IDE**: IntelliJ IDEA, Eclipse, or VS Code
- **Postman**: For API testing
- **Git**: For version control

### Local Development Setup

#### 1. Clone the Repository

```bash
git clone https://github.com/belmont-bhagat/substitute-teacher.git
cd substitute-teacher
```

#### 2. Start MongoDB

**Option A: Docker (Recommended)**
```bash
docker run -d --name mongodb -p 27017:27017 mongo:latest
```

**Option B: Local Installation**
```bash
# macOS with Homebrew
brew install mongodb-community
brew services start mongodb-community

# Ubuntu/Debian
sudo apt-get install mongodb
sudo systemctl start mongodb
```

#### 3. Backend Setup

```bash
cd simple-login-backend

# Set Java environment
export JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"

# Set JWT secret
export AUTH_JWT_SECRET='your-secure-secret-key-here'

# Run the application
./mvnw spring-boot:run
```

#### 4. Frontend Setup

```bash
cd simple-login-frontend

# Install dependencies
npm install

# Start development server
npm run dev
```

### Environment Configuration

#### Backend Environment Variables

```bash
# MongoDB connection
export MONGO_URI="mongodb://localhost:27017/simple_login"

# JWT configuration
export AUTH_JWT_SECRET="your-secure-secret-key-at-least-64-characters-long"
```

#### Frontend Environment Variables

```bash
# API base URL
export VITE_API_BASE_URL="http://localhost:8080/api"
```

### Production Deployment

#### Backend Deployment

1. **Build the JAR file**:
```bash
./mvnw clean package
```

2. **Run the application**:
```bash
java -jar target/simple-login-backend-0.0.1-SNAPSHOT.jar
```

#### Frontend Deployment

1. **Build for production**:
```bash
npm run build
```

2. **Serve static files**:
```bash
# Using serve
npm install -g serve
serve -s dist

# Using nginx
# Configure nginx to serve the dist folder
```

### Docker Deployment

#### Docker Compose Configuration

```yaml
version: '3.8'
services:
  mongodb:
    image: mongo:latest
    ports:
      - "27017:27017"
    environment:
      MONGO_INITDB_DATABASE: simple_login

  backend:
    build: ./simple-login-backend
    ports:
      - "8080:8080"
    environment:
      MONGO_URI: mongodb://mongodb:27017/simple_login
      AUTH_JWT_SECRET: your-secure-secret-key
    depends_on:
      - mongodb

  frontend:
    build: ./simple-login-frontend
    ports:
      - "3000:3000"
    depends_on:
      - backend
```

---

## Troubleshooting

### Common Issues and Solutions

#### Backend Issues

**Issue**: Port 8080 already in use
```bash
# Solution: Kill process using port 8080
lsof -t -i:8080 | xargs -r kill -9
```

**Issue**: MongoDB connection failed
```bash
# Solution: Check MongoDB status
docker ps | grep mongo
# Or for local installation
sudo systemctl status mongodb
```

**Issue**: JWT token validation failed
```bash
# Solution: Check JWT secret configuration
echo $AUTH_JWT_SECRET
# Ensure secret is at least 64 characters long
```

**Issue**: Java version mismatch
```bash
# Solution: Set correct Java version
export JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"
java -version
```

#### Frontend Issues

**Issue**: React app not loading
```bash
# Solution: Check for TypeScript errors
npm run build
# Fix any compilation errors
```

**Issue**: API calls failing
```bash
# Solution: Check proxy configuration in vite.config.ts
# Ensure backend is running on port 8080
```

**Issue**: TailwindCSS not working
```bash
# Solution: Rebuild CSS
npm run build
# Check tailwind.config.js configuration
```

#### Database Issues

**Issue**: Users not seeding
```bash
# Solution: Check MongoDB connection
# Verify DataSeeder configuration
# Check application logs for errors
```

**Issue**: Password validation failing
```bash
# Solution: Check BCrypt implementation
# Verify password hashing in DataSeeder
# Test with known good password
```

### Debugging Tips

#### Backend Debugging

1. **Enable Debug Logging**:
```properties
logging.level.com.example.simpleloginbackend=DEBUG
logging.level.org.springframework.web=DEBUG
```

2. **Check Application Logs**:
```bash
tail -f logs/application.log
```

3. **Test API Endpoints**:
```bash
curl -X POST http://localhost:8080/api/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"password"}'
```

#### Frontend Debugging

1. **Browser Developer Tools**:
   - Check Console for JavaScript errors
   - Monitor Network tab for API calls
   - Inspect Elements for CSS issues

2. **React Developer Tools**:
   - Install React DevTools browser extension
   - Inspect component state and props

3. **Vite Dev Server**:
   - Check terminal for compilation errors
   - Use hot reload for real-time debugging

### Performance Issues

#### Slow API Responses

1. **Database Optimization**:
   - Add indexes to frequently queried fields
   - Optimize MongoDB queries
   - Use connection pooling

2. **Caching**:
   - Implement Redis for session caching
   - Cache frequently accessed data
   - Use HTTP caching headers

#### Frontend Performance

1. **Bundle Size**:
   - Analyze bundle with `npm run build`
   - Use code splitting for large components
   - Remove unused dependencies

2. **Rendering Performance**:
   - Use React.memo for expensive components
   - Implement virtual scrolling for large lists
   - Optimize re-renders with useCallback/useMemo

---

## Best Practices

### Code Organization

#### Backend Best Practices

1. **Package Structure**:
```
com.example.simpleloginbackend/
├── controller/     # REST endpoints
├── service/        # Business logic
├── repository/     # Data access
├── model/          # Data models
├── config/         # Configuration
└── exception/      # Error handling
```

2. **Naming Conventions**:
   - Controllers: `*Controller`
   - Services: `*Service`
   - Repositories: `*Repository`
   - Models: `*Document` or `*Entity`

3. **Error Handling**:
```java
@ControllerAdvice
public class GlobalExceptionHandler {
    
    @ExceptionHandler(UnauthorizedException.class)
    public ResponseEntity<ErrorResponse> handleUnauthorized(UnauthorizedException e) {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body(new ErrorResponse(e.getMessage()));
    }
}
```

#### Frontend Best Practices

1. **Component Structure**:
```
src/
├── components/     # Reusable UI components
├── pages/         # Page-level components
├── hooks/         # Custom React hooks
├── lib/           # Utility functions
├── types/         # TypeScript type definitions
└── styles/        # CSS and styling
```

2. **Component Organization**:
```typescript
// Component file structure
interface Props {
  // Props interface
}

const ComponentName: React.FC<Props> = ({ prop1, prop2 }) => {
  // Hooks
  const [state, setState] = useState()
  
  // Event handlers
  const handleEvent = useCallback(() => {
    // Handler logic
  }, [dependencies])
  
  // Render
  return (
    <div>
      {/* JSX */}
    </div>
  )
}

export default ComponentName
```

### Security Best Practices

#### Authentication Security

1. **Password Security**:
   - Use BCrypt with appropriate salt rounds
   - Implement password strength requirements
   - Never store plain text passwords

2. **JWT Security**:
   - Use strong secret keys (64+ characters)
   - Set appropriate expiration times
   - Implement token refresh mechanism
   - Consider token blacklisting for logout

3. **API Security**:
   - Validate all inputs
   - Use HTTPS in production
   - Implement rate limiting
   - Log security events

#### Frontend Security

1. **Token Storage**:
   - Store tokens securely (localStorage vs sessionStorage)
   - Implement automatic token refresh
   - Clear tokens on logout

2. **Input Validation**:
   - Validate inputs on both client and server
   - Sanitize user inputs
   - Prevent XSS attacks

### Testing Best Practices

#### Unit Testing

1. **Backend Testing**:
```java
@SpringBootTest
class AuthServiceTest {
    
    @Test
    void shouldValidateCorrectCredentials() {
        // Test implementation
    }
    
    @Test
    void shouldRejectIncorrectCredentials() {
        // Test implementation
    }
}
```

2. **Frontend Testing**:
```typescript
import { render, screen } from '@testing-library/react'
import LoginPage from './LoginPage'

test('renders login form', () => {
  render(<LoginPage />)
  expect(screen.getByText('Sign in')).toBeInTheDocument()
})
```

#### Integration Testing

1. **API Testing**:
   - Test complete request/response cycles
   - Verify authentication flows
   - Test error scenarios

2. **End-to-End Testing**:
   - Test complete user workflows
   - Verify cross-browser compatibility
   - Test responsive design

### Documentation Best Practices

#### Code Documentation

1. **Java Documentation**:
```java
/**
 * Service for handling user authentication operations.
 * 
 * @author Your Name
 * @version 1.0
 */
@Service
public class AuthService {
    
    /**
     * Validates user credentials against the database.
     * 
     * @param username the username to validate
     * @param rawPassword the plain text password
     * @return true if credentials are valid, false otherwise
     */
    public boolean validateCredentials(String username, String rawPassword) {
        // Implementation
    }
}
```

2. **TypeScript Documentation**:
```typescript
/**
 * Interface representing a user in the system.
 */
interface User {
  /** Unique identifier for the user */
  id: string
  /** Username for login */
  username: string
  /** User's email address */
  email: string
  /** User's role (instructor or student) */
  role: 'instructor' | 'student'
}

/**
 * Hook for managing user authentication state.
 * 
 * @returns Object containing authentication state and methods
 */
export const useAuth = () => {
  // Implementation
}
```

#### API Documentation

1. **OpenAPI/Swagger**:
```yaml
openapi: 3.0.0
info:
  title: Simple Login API
  version: 1.0.0
paths:
  /api/login:
    post:
      summary: User login
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                username:
                  type: string
                password:
                  type: string
```

---

## Reference Section

### JWT (JSON Web Tokens)

#### What is JWT?

JWT is a compact, URL-safe means of representing claims to be transferred between two parties. It's commonly used for authentication and information exchange.

#### JWT Structure

A JWT consists of three parts separated by dots (`.`):

```
header.payload.signature
```

**Header**:
```json
{
  "alg": "HS256",
  "typ": "JWT"
}
```

**Payload**:
```json
{
  "sub": "1234567890",
  "name": "John Doe",
  "iat": 1516239022,
  "exp": 1516242622
}
```

**Signature**:
```
HMACSHA256(
  base64UrlEncode(header) + "." +
  base64UrlEncode(payload),
  secret
)
```

#### JWT Advantages

1. **Stateless**: No server-side session storage needed
2. **Scalable**: Works across multiple servers
3. **Self-contained**: Contains all necessary information
4. **Secure**: Cryptographically signed

#### JWT Disadvantages

1. **Size**: Larger than session IDs
2. **Revocation**: Difficult to invalidate before expiration
3. **Security**: Secret key compromise affects all tokens

### MongoDB

#### What is MongoDB?

MongoDB is a NoSQL document database that stores data in flexible, JSON-like documents. It's designed for scalability and flexibility.

#### MongoDB Concepts

**Database**: A container for collections
**Collection**: A group of documents (similar to a table)
**Document**: A record in a collection (similar to a row)
**Field**: A key-value pair in a document (similar to a column)

#### MongoDB Operations

**Create Document**:
```javascript
db.users.insertOne({
  username: "admin",
  email: "admin@example.com",
  role: "instructor"
})
```

**Find Documents**:
```javascript
db.users.find({ role: "student" })
db.users.findOne({ username: "admin" })
```

**Update Document**:
```javascript
db.users.updateOne(
  { username: "admin" },
  { $set: { email: "newemail@example.com" } }
)
```

**Delete Document**:
```javascript
db.users.deleteOne({ username: "admin" })
```

### Spring Boot

#### What is Spring Boot?

Spring Boot is a framework that simplifies the development of Spring applications by providing auto-configuration, starter dependencies, and embedded servers.

#### Key Features

1. **Auto-configuration**: Automatically configures Spring and third-party libraries
2. **Starter Dependencies**: Pre-configured dependency sets
3. **Embedded Servers**: Built-in Tomcat, Jetty, or Undertow
4. **Production-ready**: Health checks, metrics, and externalized configuration

#### Spring Boot Annotations

- `@SpringBootApplication`: Main application class
- `@RestController`: REST API controller
- `@Service`: Service layer component
- `@Repository`: Data access layer component
- `@Component`: Generic Spring component
- `@Autowired`: Dependency injection
- `@RequestMapping`: URL mapping
- `@PostMapping`: POST request mapping
- `@GetMapping`: GET request mapping

### React

#### What is React?

React is a JavaScript library for building user interfaces, particularly web applications. It's maintained by Facebook and uses a component-based architecture.

#### Key Concepts

1. **Components**: Reusable UI pieces
2. **Props**: Data passed to components
3. **State**: Internal component data
4. **Hooks**: Functions that let you use state and lifecycle features
5. **JSX**: JavaScript XML syntax extension

#### React Hooks

**useState**:
```typescript
const [count, setCount] = useState(0)
```

**useEffect**:
```typescript
useEffect(() => {
  // Side effects
}, [dependencies])
```

**useCallback**:
```typescript
const memoizedCallback = useCallback(() => {
  // Function logic
}, [dependencies])
```

**useMemo**:
```typescript
const memoizedValue = useMemo(() => {
  // Expensive calculation
}, [dependencies])
```

### TypeScript

#### What is TypeScript?

TypeScript is a typed superset of JavaScript that compiles to plain JavaScript. It adds static type checking and other features to JavaScript.

#### TypeScript Features

1. **Static Typing**: Catch errors at compile time
2. **Interfaces**: Define object shapes
3. **Generics**: Reusable components
4. **Enums**: Named constants
5. **Decorators**: Metadata for classes

#### TypeScript Types

**Basic Types**:
```typescript
let name: string = "John"
let age: number = 30
let isActive: boolean = true
let items: string[] = ["item1", "item2"]
```

**Interfaces**:
```typescript
interface User {
  id: number
  name: string
  email?: string  // Optional property
}
```

**Generics**:
```typescript
function identity<T>(arg: T): T {
  return arg
}
```

### REST API Design

#### REST Principles

1. **Stateless**: Each request contains all necessary information
2. **Client-Server**: Separation of concerns
3. **Cacheable**: Responses can be cached
4. **Uniform Interface**: Consistent API design
5. **Layered System**: Hierarchical layers

#### HTTP Methods

- **GET**: Retrieve data
- **POST**: Create new resources
- **PUT**: Update entire resource
- **PATCH**: Partial update
- **DELETE**: Remove resource

#### HTTP Status Codes

**2xx Success**:
- 200 OK: Request successful
- 201 Created: Resource created
- 204 No Content: Success with no response body

**4xx Client Error**:
- 400 Bad Request: Invalid request
- 401 Unauthorized: Authentication required
- 403 Forbidden: Access denied
- 404 Not Found: Resource not found

**5xx Server Error**:
- 500 Internal Server Error: Server error
- 502 Bad Gateway: Invalid response from upstream
- 503 Service Unavailable: Server temporarily unavailable

### Security Best Practices

#### Authentication vs Authorization

**Authentication**: Verifying who you are
**Authorization**: Verifying what you can do

#### Password Security

1. **Hashing**: Use bcrypt, scrypt, or Argon2
2. **Salt**: Add random data to passwords before hashing
3. **Strength**: Enforce strong password policies
4. **Storage**: Never store plain text passwords

#### HTTPS

Always use HTTPS in production to:
- Encrypt data in transit
- Prevent man-in-the-middle attacks
- Ensure data integrity
- Build user trust

#### CORS (Cross-Origin Resource Sharing)

Configure CORS properly:
```java
@CrossOrigin(origins = "https://yourdomain.com")
```

#### Input Validation

1. **Client-side**: Immediate feedback
2. **Server-side**: Security enforcement
3. **Sanitization**: Remove dangerous characters
4. **Whitelist**: Allow only known good inputs

### Testing Strategies

#### Testing Pyramid

1. **Unit Tests**: Test individual components
2. **Integration Tests**: Test component interactions
3. **End-to-End Tests**: Test complete workflows

#### Test Types

**Unit Tests**:
- Fast execution
- Isolated testing
- High coverage
- Mock dependencies

**Integration Tests**:
- Test real interactions
- Use test databases
- Verify API contracts
- Test error scenarios

**E2E Tests**:
- Test user workflows
- Cross-browser testing
- Performance testing
- Accessibility testing

### Performance Optimization

#### Frontend Optimization

1. **Code Splitting**: Load code on demand
2. **Lazy Loading**: Load components when needed
3. **Memoization**: Cache expensive calculations
4. **Virtual Scrolling**: Handle large lists efficiently
5. **Image Optimization**: Compress and resize images

#### Backend Optimization

1. **Database Indexing**: Speed up queries
2. **Connection Pooling**: Reuse database connections
3. **Caching**: Store frequently accessed data
4. **Pagination**: Limit data transfer
5. **Compression**: Reduce response sizes

#### Monitoring

1. **Application Metrics**: Response times, error rates
2. **Resource Usage**: CPU, memory, disk usage
3. **User Analytics**: Usage patterns, performance
4. **Error Tracking**: Log and monitor errors

---

## Conclusion

This Simple Login Application demonstrates modern full-stack development practices and provides a solid foundation for learning web development. The project covers authentication, database integration, API design, and user interface development.

### Key Takeaways

1. **Full-Stack Integration**: Understanding how frontend and backend communicate
2. **Security Implementation**: Proper authentication and authorization
3. **Modern Development**: Using current tools and frameworks
4. **Testing Practices**: Comprehensive testing strategies
5. **Best Practices**: Following industry standards and conventions

### Next Steps

1. **Extend Functionality**: Add more features like user management, file uploads
2. **Improve Security**: Implement refresh tokens, rate limiting
3. **Add Testing**: Write comprehensive unit and integration tests
4. **Deploy**: Set up production deployment with CI/CD
5. **Monitor**: Add logging, metrics, and error tracking

### Resources for Further Learning

- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [React Documentation](https://reactjs.org/docs)
- [MongoDB Documentation](https://docs.mongodb.com)
- [JWT.io](https://jwt.io)
- [TypeScript Handbook](https://www.typescriptlang.org/docs)

---

*This guide was created to help students understand the Simple Login Application project. For questions or contributions, please refer to the project repository.*

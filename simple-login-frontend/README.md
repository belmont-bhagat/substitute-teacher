# Simple Login Frontend (No Dashboard Branch)

React frontend application with TypeScript. In this branch, only the Login and Profile pages are present. Dashboard routes and components have been removed.

## 🏗️ Technology Stack

- **Framework**: React 18 with TypeScript
- **Build Tool**: Vite
- **Styling**: Tailwind CSS
- **Routing**: React Router
- **HTTP Client**: Axios
- **State Management**: Local Storage

## 🚀 Quick Start

### Prerequisites

- Node.js 18 or higher
- npm 9+ or yarn (npm comes with Node.js)

### Installation & Setup

1. **Install dependencies**
   ```bash
   npm install
   ```

2. **Start development server**
   ```bash
   npm run dev
   ```

3. **Access the application**
   - URL: http://localhost:5173
   - Hot reload enabled

## 📁 Project Structure

```
src/
├── components/              # Reusable UI components
│   ├── AuthLayout.tsx       # Authentication layout wrapper
│   ├── Button.tsx           # Custom button component
│   ├── Card.tsx             # Card container component
│   ├── Input.tsx            # Form input component
│   └── Logo.tsx             # Application logo
├── lib/                     # Utility libraries
│   ├── api.ts               # Axios API client configuration
│   └── auth.ts              # Authentication utilities
├── pages/                   # Page components
│   ├── LoginPage.tsx        # Login form page
│   └── ProfilePage.tsx      # User profile page
├── App.tsx                  # Main application component
├── main.tsx                 # Application entry point
└── index.css                # Global styles
```

## 🔧 Configuration

### API Configuration

The frontend connects to the Spring Boot backend:

```typescript
// src/lib/api.ts
const api = axios.create({
  baseURL: 'http://localhost:8080/api',
})
```

### Environment Variables

Create a `.env` file for environment-specific configuration:

```env
VITE_API_BASE_URL=http://localhost:8080/api
```

## 🔐 Authentication Flow

1. **Login Process**
   ```typescript
   // User submits login form
   const response = await api.post('/login', { username, password })
   
   // Store JWT token
   setToken(response.data.token)
   
   // Redirect to profile
   navigate('/profile')
   ```

2. **Token Management**
   ```typescript
   // Store token in localStorage
   localStorage.setItem('auth_token', token)
   
   // Include token in API requests
   config.headers['Authorization'] = `Bearer ${token}`
   ```

3. **Route Protection**
   ```typescript
   // Check authentication on protected routes
   const token = getToken()
   if (!token) {
     navigate('/login')
   }
   ```

## 🔧 API Integration

### Axios Configuration
```typescript
// Automatic token injection
api.interceptors.request.use((config) => {
  const token = getToken()
  if (token) {
    config.headers['Authorization'] = `Bearer ${token}`
  }
  return config
})
```

### Error Handling
```typescript
try {
  const response = await api.get('/profile')
  setProfile(response.data)
} catch (error) {
  setError('Unauthorized')
  clearToken()
  navigate('/login')
}
```

## 🧪 Testing

### Manual Testing
1. **Login Flow**
   - Enter credentials: `admin` / `password`
   - Verify redirect to profile page
   - Check token storage in browser dev tools

2. **Route Protection**
   - Try accessing `/profile` without login
   - Verify redirect to login page

3. **Logout**
   - Click logout button
   - Verify token removal and redirect

---

This branch removes dashboard routes and pages to focus on the minimal login → profile flow.
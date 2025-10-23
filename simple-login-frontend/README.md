# Simple Login Frontend

React frontend application with TypeScript, providing a modern user interface for authentication and user management.

## 🏗️ Technology Stack

- **Framework**: React 18 with TypeScript
- **Build Tool**: Vite
- **Styling**: Tailwind CSS
- **Routing**: React Router
- **HTTP Client**: Axios
- **State Management**: React Context + Local Storage

## 🚀 Quick Start

### Prerequisites

- Node.js 18 or higher
- npm or yarn

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
│   ├── Button.tsx          # Custom button component
│   ├── Card.tsx            # Card container component
│   ├── Input.tsx           # Form input component
│   └── Logo.tsx            # Application logo
├── lib/                    # Utility libraries
│   ├── api.ts              # Axios API client configuration
│   └── auth.ts             # Authentication utilities
├── pages/                  # Page components
│   ├── LoginPage.tsx       # Login form page
│   └── ProfilePage.tsx     # User profile page
├── App.tsx                 # Main application component
├── main.tsx               # Application entry point
└── index.css              # Global styles
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

## 🎨 UI Components

### AuthLayout
- Wrapper component for authenticated pages
- Handles route protection
- Redirects to login if not authenticated

### LoginPage
- Email/password login form
- Form validation
- Error handling
- Redirects to profile on success

### ProfilePage
- Displays user information
- Logout functionality
- Protected route

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

## 🎯 Features

### Authentication
- Login form with validation
- JWT token storage and management
- Automatic token inclusion in API requests
- Route protection

### User Interface
- Responsive design with Tailwind CSS
- Clean, modern interface
- Loading states and error handling
- Form validation

### State Management
- React Context for global state
- Local storage for persistence
- Automatic token refresh handling

## 🛠️ Development

### Available Scripts

```bash
# Start development server
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview

# Lint code
npm run lint
```

### Hot Reload
Vite provides instant hot module replacement (HMR) for:
- Component changes
- Style updates
- TypeScript changes

## 🎨 Styling

### Tailwind CSS
The application uses Tailwind CSS for styling:

```css
/* Custom styles in index.css */
@tailwind base;
@tailwind components;
@tailwind utilities;
```

### Component Styling
Components use Tailwind utility classes:

```tsx
<button className="w-full bg-gray-900 text-white py-2 rounded-md hover:bg-black">
  Sign in
</button>
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

## 📱 Responsive Design

The application is fully responsive:
- Mobile-first design approach
- Tailwind responsive utilities
- Flexible layouts

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

## 🔧 Troubleshooting

### Common Issues

1. **API Connection Errors**
   - Ensure backend is running on port 8080
   - Check CORS configuration in backend
   - Verify API base URL in configuration

2. **Authentication Issues**
   - Check token storage in localStorage
   - Verify token format and expiration
   - Check browser network tab for API calls

3. **Build Issues**
   - Clear node_modules: `rm -rf node_modules && npm install`
   - Check Node.js version compatibility
   - Verify TypeScript configuration

### Debug Mode

Enable debug logging in browser console:
```typescript
// Add to api.ts for debugging
api.interceptors.response.use(
  response => {
    console.log('API Response:', response)
    return response
  },
  error => {
    console.error('API Error:', error)
    return Promise.reject(error)
  }
)
```

## 📚 Dependencies

Key dependencies in `package.json`:

- `react`: UI framework
- `react-dom`: DOM rendering
- `react-router-dom`: Client-side routing
- `axios`: HTTP client
- `tailwindcss`: CSS framework
- `typescript`: Type safety
- `vite`: Build tool and dev server

## 🎯 Learning Objectives

This frontend demonstrates:

1. **React Fundamentals**
   - Component composition
   - Props and state management
   - Event handling

2. **TypeScript Integration**
   - Type safety
   - Interface definitions
   - Type checking

3. **Modern Build Tools**
   - Vite configuration
   - Hot module replacement
   - Production builds

4. **Authentication Patterns**
   - Token-based authentication
   - Route protection
   - State persistence

5. **API Integration**
   - HTTP client configuration
   - Error handling
   - Request/response interceptors

6. **Styling Approaches**
   - Utility-first CSS
   - Responsive design
   - Component styling

---

**Perfect for teaching React, TypeScript, and modern frontend development!**
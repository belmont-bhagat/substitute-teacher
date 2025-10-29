import axios from 'axios'
import { getToken, clearToken } from './auth'

const api = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL || 'http://localhost:8080/api',
})

// Request interceptor to add auth token
api.interceptors.request.use((config) => {
  const token = getToken()
  if (token) {
    config.headers = config.headers ?? {}
    config.headers['Authorization'] = `Bearer ${token}`
  }
  return config
})

// Response interceptor for error handling
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      // Token expired or invalid
      clearToken()
      window.location.href = '/login'
    }
    return Promise.reject(error)
  }
)

// Auth endpoints
export const authApi = {
  login: (credentials: { username: string; password: string }) =>
    api.post('/login', credentials),
  
  getProfile: () =>
    api.get('/profile'),
  
  getAllUsers: () =>
    api.get('/users')
}

export default api

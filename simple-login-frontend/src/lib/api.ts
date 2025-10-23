import axios from 'axios'
import { getToken } from './auth'

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
      localStorage.removeItem('token')
      window.location.href = '/login'
    }
    return Promise.reject(error)
  }
)

// Auth endpoints
export const authApi = {
  login: (credentials: { username: string; password: string }) =>
    api.post('/auth/login', credentials),
  
  getProfile: () =>
    api.get('/auth/profile'),
  
  getAllUsers: () =>
    api.get('/users')
}

// Admin endpoints
export const adminApi = {
  getUsers: (params?: { page?: number; size?: number; query?: string }) =>
    api.get('/admin/users', { params }),
  
  updateUser: (userId: string, updates: any) =>
    api.patch(`/admin/users/${userId}`, updates),
  
  getStats: () =>
    api.get('/admin/stats')
}

// User endpoints
export const userApi = {
  updateProfile: (updates: any) =>
    api.patch('/user/profile', updates),
  
  changePassword: (passwordData: { currentPassword: string; newPassword: string }) =>
    api.post('/user/change-password', passwordData)
}

export default api

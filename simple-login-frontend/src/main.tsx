import React from 'react'
import ReactDOM from 'react-dom/client'
import { createBrowserRouter, RouterProvider } from 'react-router-dom'
import './index.css'
import App from './App'
import LoginPage from './pages/LoginPage'
import ProfilePage from './pages/ProfilePage'
import DashboardLayout from './components/DashboardLayout'
import DashboardHome from './pages/DashboardHome'
import UsersDashboard from './pages/UsersDashboard'
import DashboardSettings from './pages/DashboardSettings'

const router = createBrowserRouter([
  { path: '/', element: <LoginPage /> },
  { path: '/login', element: <LoginPage /> },
  { path: '/profile', element: <ProfilePage /> },
  {
    path: '/dashboard',
    element: <DashboardLayout />,
    children: [
      { index: true, element: <DashboardHome /> },
      { path: 'users', element: <UsersDashboard /> },
      { path: 'settings', element: <DashboardSettings /> },
    ],
  },
])

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <RouterProvider router={router} />
  </React.StrictMode>,
)

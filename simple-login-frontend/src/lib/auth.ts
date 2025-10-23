export const TOKEN_KEY = 'auth_token'

export function getToken(): string | null {
  return localStorage.getItem(TOKEN_KEY)
}

export function setToken(token: string): void {
  localStorage.setItem(TOKEN_KEY, token)
}

export function clearToken(): void {
  localStorage.removeItem(TOKEN_KEY)
}

export function logout(): void {
  clearToken()
}

export async function getCurrentUser(): Promise<{ username: string; role: string } | null> {
  const token = getToken()
  if (!token) {
    return null
  }

  try {
    const response = await fetch('http://localhost:8080/api/auth/profile', {
      headers: {
        'Authorization': `Bearer ${token}`
      }
    })

    if (!response.ok) {
      clearToken()
      return null
    }

    const userData = await response.json()
    return {
      username: userData.username,
      role: userData.role
    }
  } catch (error) {
    console.error('Failed to get current user:', error)
    clearToken()
    return null
  }
}

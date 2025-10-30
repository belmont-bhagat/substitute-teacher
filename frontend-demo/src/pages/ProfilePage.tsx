import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import api from '../lib/api'
import { clearToken, getToken } from '../lib/auth'
import { Card, CardBody, CardHeader } from '../components/Card'
import AuthLayout from '../components/AuthLayout'

export default function ProfilePage() {
  const navigate = useNavigate()
  const [profile, setProfile] = useState<{ username: string; role: string } | null>(null)
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    const token = getToken()
    if (!token) {
      navigate('/login')
      return
    }
    api
      .get('/profile')
      .then((res) => setProfile(res.data))
      .catch(() => {
        setError('Unauthorized')
        clearToken()
        navigate('/login')
      })
  }, [navigate])

  function handleLogout() {
    clearToken()
    navigate('/login')
  }

  if (error) return null

  return (
    <AuthLayout>
      <Card className="w-full">
        <CardHeader title="Profile" />
        <CardBody>
          {profile ? (
            <div className="space-y-6">
              <dl className="divide-y divide-gray-200">
                <div className="grid grid-cols-3 items-center gap-2 py-3">
                  <dt className="col-span-1 text-sm text-gray-500">Username</dt>
                  <dd className="col-span-2 text-right text-gray-900 break-words">{profile.username}</dd>
                </div>
                <div className="grid grid-cols-3 items-center gap-2 py-3">
                  <dt className="col-span-1 text-sm text-gray-500">Role</dt>
                  <dd className="col-span-2 text-right text-gray-900 capitalize">{profile.role}</dd>
                </div>
              </dl>
              <button onClick={handleLogout} className="w-full bg-gray-900 text-white py-2 rounded-md hover:bg-black">Logout</button>
            </div>
          ) : (
            <div className="py-6 text-center text-gray-500">Loading…</div>
          )}
        </CardBody>
      </Card>
    </AuthLayout>
  )
}

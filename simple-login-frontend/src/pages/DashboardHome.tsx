import React, { useState, useEffect } from 'react';
import MetricCard from '../components/MetricCard';

interface DashboardStats {
  totalUsers: number;
  activeUsers: number;
  inactiveUsers: number;
  adminUsers: number;
  regularUsers: number;
  todayLogins: number;
}

export default function DashboardHome() {
  const [stats, setStats] = useState<DashboardStats | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchStats = async () => {
      try {
        const response = await fetch('/api/admin/stats', {
          headers: {
            'Authorization': `Bearer ${localStorage.getItem('token')}`
          }
        });

        if (!response.ok) {
          throw new Error('Failed to fetch dashboard stats');
        }

        const data = await response.json();
        setStats(data);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'An error occurred');
      } finally {
        setLoading(false);
      }
    };

    fetchStats();
  }, []);

  if (loading) {
    return (
      <div className="space-y-6">
        <div className="animate-pulse">
          <div className="h-8 bg-gray-200 rounded w-1/4 mb-6"></div>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {[...Array(6)].map((_, i) => (
              <div key={i} className="h-32 bg-gray-200 rounded-lg"></div>
            ))}
          </div>
        </div>
      </div>
    );
  }

  if (error) {
    return (
      <div className="bg-red-50 border border-red-200 rounded-lg p-6">
        <div className="flex items-center">
          <div className="text-red-400 mr-3">⚠️</div>
          <div>
            <h3 className="text-red-800 font-medium">Error Loading Dashboard</h3>
            <p className="text-red-600 text-sm mt-1">{error}</p>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-gray-900">Dashboard</h1>
        <p className="text-gray-600 mt-2">Welcome to your Simple Login dashboard</p>
      </div>

      {stats && (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          <MetricCard
            title="Total Users"
            value={stats.totalUsers}
            description="All registered users"
            icon="👥"
            color="blue"
          />
          
          <MetricCard
            title="Active Users"
            value={stats.activeUsers}
            description="Currently active accounts"
            icon="✅"
            color="green"
          />
          
          <MetricCard
            title="Inactive Users"
            value={stats.inactiveUsers}
            description="Deactivated accounts"
            icon="❌"
            color="red"
          />
          
          <MetricCard
            title="Admin Users"
            value={stats.adminUsers}
            description="Users with admin privileges"
            icon="👑"
            color="purple"
          />
          
          <MetricCard
            title="Regular Users"
            value={stats.regularUsers}
            description="Standard user accounts"
            icon="👤"
            color="blue"
          />
          
          <MetricCard
            title="Today's Logins"
            value={stats.todayLogins}
            description="Users who logged in today"
            icon="📅"
            color="yellow"
          />
        </div>
      )}

      <div className="bg-white rounded-lg shadow-md p-6">
        <h2 className="text-xl font-semibold text-gray-900 mb-4">Quick Actions</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
          <button className="bg-blue-500 hover:bg-blue-600 text-white px-4 py-3 rounded-lg text-center transition-colors">
            <div className="text-2xl mb-2">👥</div>
            <div className="font-medium">Manage Users</div>
          </button>
          
          <button className="bg-green-500 hover:bg-green-600 text-white px-4 py-3 rounded-lg text-center transition-colors">
            <div className="text-2xl mb-2">👤</div>
            <div className="font-medium">View Profile</div>
          </button>
          
          <button className="bg-purple-500 hover:bg-purple-600 text-white px-4 py-3 rounded-lg text-center transition-colors">
            <div className="text-2xl mb-2">⚙️</div>
            <div className="font-medium">Settings</div>
          </button>
          
          <button className="bg-yellow-500 hover:bg-yellow-600 text-white px-4 py-3 rounded-lg text-center transition-colors">
            <div className="text-2xl mb-2">📊</div>
            <div className="font-medium">Analytics</div>
          </button>
        </div>
      </div>
    </div>
  );
}

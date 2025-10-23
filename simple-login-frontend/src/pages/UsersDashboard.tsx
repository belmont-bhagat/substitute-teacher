import React, { useState, useEffect } from 'react';
import UsersTable from '../components/UsersTable';

interface User {
  id: string;
  username: string;
  role: string;
  isActive: boolean;
  lastLoginAt?: string;
  createdAt: string;
}

interface UsersResponse {
  users: User[];
  currentPage: number;
  totalItems: number;
  totalPages: number;
  hasNext: boolean;
  hasPrevious: boolean;
}

export default function UsersDashboard() {
  const [users, setUsers] = useState<User[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [pagination, setPagination] = useState({
    currentPage: 0,
    totalPages: 0,
    totalItems: 0,
    hasNext: false,
    hasPrevious: false
  });

  const fetchUsers = async (page = 0, size = 10, query = '') => {
    try {
      setLoading(true);
      const params = new URLSearchParams({
        page: page.toString(),
        size: size.toString(),
        ...(query && { query })
      });

      const response = await fetch(`/api/admin/users?${params}`, {
        headers: {
          'Authorization': `Bearer ${localStorage.getItem('token')}`
        }
      });

      if (!response.ok) {
        if (response.status === 403) {
          throw new Error('Access denied. Admin privileges required.');
        }
        throw new Error('Failed to fetch users');
      }

      const data: UsersResponse = await response.json();
      setUsers(data.users);
      setPagination({
        currentPage: data.currentPage,
        totalPages: data.totalPages,
        totalItems: data.totalItems,
        hasNext: data.hasNext,
        hasPrevious: data.hasPrevious
      });
    } catch (err) {
      setError(err instanceof Error ? err.message : 'An error occurred');
    } finally {
      setLoading(false);
    }
  };

  const updateUser = async (userId: string, updates: Partial<User>) => {
    try {
      const response = await fetch(`/api/admin/users/${userId}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${localStorage.getItem('token')}`
        },
        body: JSON.stringify(updates)
      });

      if (!response.ok) {
        throw new Error('Failed to update user');
      }

      // Refresh the users list
      await fetchUsers(pagination.currentPage);
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to update user');
    }
  };

  useEffect(() => {
    fetchUsers();
  }, []);

  if (error) {
    return (
      <div className="bg-red-50 border border-red-200 rounded-lg p-6">
        <div className="flex items-center">
          <div className="text-red-400 mr-3">⚠️</div>
          <div>
            <h3 className="text-red-800 font-medium">Error Loading Users</h3>
            <p className="text-red-600 text-sm mt-1">{error}</p>
            <button
              onClick={() => fetchUsers()}
              className="mt-3 bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded text-sm"
            >
              Try Again
            </button>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-3xl font-bold text-gray-900">Users Management</h1>
        <p className="text-gray-600 mt-2">Manage user accounts, roles, and permissions</p>
      </div>

      <UsersTable 
        users={users} 
        onUpdateUser={updateUser}
        loading={loading}
      />

      {/* Pagination */}
      {!loading && pagination.totalPages > 1 && (
        <div className="bg-white rounded-lg shadow-md p-6">
          <div className="flex items-center justify-between">
            <div className="text-sm text-gray-700">
              Showing {pagination.currentPage * 10 + 1} to {Math.min((pagination.currentPage + 1) * 10, pagination.totalItems)} of {pagination.totalItems} users
            </div>
            
            <div className="flex space-x-2">
              <button
                onClick={() => fetchUsers(pagination.currentPage - 1)}
                disabled={!pagination.hasPrevious}
                className="px-3 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
              >
                Previous
              </button>
              
              <span className="px-3 py-2 text-sm text-gray-700">
                Page {pagination.currentPage + 1} of {pagination.totalPages}
              </span>
              
              <button
                onClick={() => fetchUsers(pagination.currentPage + 1)}
                disabled={!pagination.hasNext}
                className="px-3 py-2 border border-gray-300 rounded-md text-sm font-medium text-gray-700 bg-white hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
              >
                Next
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}

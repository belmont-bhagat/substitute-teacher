import React from 'react';
import { Link, useLocation } from 'react-router-dom';

interface SidebarProps {
  userRole: string;
  isOpen: boolean;
  onToggle: () => void;
}

export default function Sidebar({ userRole, isOpen, onToggle }: SidebarProps) {
  const location = useLocation();

  const menuItems = [
    {
      name: 'Dashboard',
      path: '/dashboard',
      icon: '📊',
      roles: ['USER', 'ADMIN']
    },
    {
      name: 'Users Management',
      path: '/dashboard/users',
      icon: '👥',
      roles: ['ADMIN']
    },
    {
      name: 'Profile',
      path: '/dashboard/profile',
      icon: '👤',
      roles: ['USER', 'ADMIN']
    },
    {
      name: 'Settings',
      path: '/dashboard/settings',
      icon: '⚙️',
      roles: ['USER', 'ADMIN']
    }
  ];

  const filteredMenuItems = menuItems.filter(item => 
    item.roles.includes(userRole)
  );

  return (
    <>
      {/* Mobile overlay */}
      {isOpen && (
        <div 
          className="fixed inset-0 bg-black bg-opacity-50 z-40 lg:hidden"
          onClick={onToggle}
        />
      )}

      {/* Sidebar */}
      <div className={`
        fixed top-0 left-0 h-full bg-gray-800 text-white z-50 transform transition-transform duration-300 ease-in-out
        ${isOpen ? 'translate-x-0' : '-translate-x-full'}
        lg:translate-x-0 lg:static lg:z-auto
        w-64
      `}>
        <div className="p-6">
          <div className="flex items-center justify-between">
            <h2 className="text-xl font-bold">Simple Login</h2>
            <button 
              onClick={onToggle}
              className="lg:hidden text-white hover:text-gray-300"
            >
              ✕
            </button>
          </div>
        </div>

        <nav className="mt-6">
          <ul className="space-y-2 px-6">
            {filteredMenuItems.map((item) => (
              <li key={item.path}>
                <Link
                  to={item.path}
                  className={`
                    flex items-center space-x-3 px-4 py-3 rounded-lg transition-colors
                    ${location.pathname === item.path 
                      ? 'bg-blue-600 text-white' 
                      : 'text-gray-300 hover:bg-gray-700 hover:text-white'
                    }
                  `}
                  onClick={() => {
                    // Close mobile menu when navigating
                    if (window.innerWidth < 1024) {
                      onToggle();
                    }
                  }}
                >
                  <span className="text-lg">{item.icon}</span>
                  <span>{item.name}</span>
                </Link>
              </li>
            ))}
          </ul>
        </nav>

        <div className="absolute bottom-6 left-6 right-6">
          <div className="bg-gray-700 rounded-lg p-4">
            <p className="text-sm text-gray-300">Role: {userRole}</p>
          </div>
        </div>
      </div>
    </>
  );
}

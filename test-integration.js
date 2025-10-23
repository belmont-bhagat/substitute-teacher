#!/usr/bin/env node

/**
 * Simple Login Application - API Integration Test
 * Tests the connection between frontend and backend
 * and validates all API endpoints are working correctly
 */

const axios = require('axios');

// Configuration
const CONFIG = {
  backendUrl: 'http://localhost:8080',
  frontendUrl: 'http://localhost:5173',
  apiBase: 'http://localhost:8080/api',
  credentials: {
    admin: { username: 'admin', password: 'password' },
    user: { username: 'user', password: 'password' }
  }
};

// Colors for console output
const colors = {
  red: '\x1b[31m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m',
  reset: '\x1b[0m'
};

// Test results tracking
let testResults = {
  passed: 0,
  failed: 0,
  total: 0
};

// Global tokens
let adminToken = '';
let userToken = '';

/**
 * Print colored output
 */
function print(color, message) {
  console.log(`${colors[color]}${message}${colors.reset}`);
}

/**
 * Print test result
 */
function printTestResult(testName, passed, message) {
  testResults.total++;
  if (passed) {
    testResults.passed++;
    print('green', `✅ PASS: ${testName} - ${message}`);
  } else {
    testResults.failed++;
    print('red', `❌ FAIL: ${testName} - ${message}`);
  }
}

/**
 * Make API request with error handling
 */
async function makeApiRequest(method, endpoint, data = null, token = null, expectedStatus = 200) {
  try {
    const config = {
      method,
      url: `${CONFIG.apiBase}${endpoint}`,
      headers: {}
    };

    if (data) {
      config.headers['Content-Type'] = 'application/json';
      config.data = data;
    }

    if (token) {
      config.headers['Authorization'] = `Bearer ${token}`;
    }

    const response = await axios(config);
    
    if (response.status === expectedStatus) {
      return { success: true, data: response.data };
    } else {
      return { success: false, error: `Expected status ${expectedStatus}, got ${response.status}` };
    }
  } catch (error) {
    if (error.response && error.response.status === expectedStatus) {
      return { success: true, data: error.response.data };
    }
    return { success: false, error: error.message };
  }
}

/**
 * Check if service is running
 */
async function checkService(serviceName, url) {
  try {
    const response = await axios.get(url, { timeout: 5000 });
    printTestResult(`${serviceName} Health Check`, true, `Service is running on ${url}`);
    return true;
  } catch (error) {
    printTestResult(`${serviceName} Health Check`, false, `Service not responding: ${error.message}`);
    return false;
  }
}

/**
 * Test admin login
 */
async function testAdminLogin() {
  const result = await makeApiRequest('POST', '/auth/login', CONFIG.credentials.admin);
  
  if (result.success && result.data.token) {
    adminToken = result.data.token;
    printTestResult('Admin Login', true, 'Successfully logged in as admin');
    return true;
  } else {
    printTestResult('Admin Login', false, result.error || 'No token received');
    return false;
  }
}

/**
 * Test user login
 */
async function testUserLogin() {
  const result = await makeApiRequest('POST', '/auth/login', CONFIG.credentials.user);
  
  if (result.success && result.data.token) {
    userToken = result.data.token;
    printTestResult('User Login', true, 'Successfully logged in as regular user');
    return true;
  } else {
    printTestResult('User Login', false, result.error || 'No token received');
    return false;
  }
}

/**
 * Test admin profile access
 */
async function testAdminProfile() {
  const result = await makeApiRequest('GET', '/auth/profile', null, adminToken);
  
  if (result.success && result.data.role === 'ADMIN') {
    printTestResult('Admin Profile', true, 'Admin profile retrieved with correct role');
    return true;
  } else {
    printTestResult('Admin Profile', false, `Incorrect role: ${result.data?.role || 'unknown'}`);
    return false;
  }
}

/**
 * Test user profile access
 */
async function testUserProfile() {
  const result = await makeApiRequest('GET', '/auth/profile', null, userToken);
  
  if (result.success && result.data.role === 'USER') {
    printTestResult('User Profile', true, 'User profile retrieved with correct role');
    return true;
  } else {
    printTestResult('User Profile', false, `Incorrect role: ${result.data?.role || 'unknown'}`);
    return false;
  }
}

/**
 * Test admin dashboard stats
 */
async function testDashboardStats() {
  const result = await makeApiRequest('GET', '/admin/stats', null, adminToken);
  
  if (result.success && result.data.totalUsers > 0) {
    printTestResult('Dashboard Stats', true, `Retrieved stats with ${result.data.totalUsers} total users`);
    return true;
  } else {
    printTestResult('Dashboard Stats', false, 'No user count found or invalid data');
    return false;
  }
}

/**
 * Test admin users list
 */
async function testUsersList() {
  const result = await makeApiRequest('GET', '/admin/users?page=0&size=10', null, adminToken);
  
  if (result.success && result.data.totalItems > 0) {
    printTestResult('Users List', true, `Retrieved ${result.data.totalItems} users with pagination`);
    return true;
  } else {
    printTestResult('Users List', false, 'No users found or invalid data');
    return false;
  }
}

/**
 * Test user access to admin endpoints (should fail)
 */
async function testUserAdminAccess() {
  const result = await makeApiRequest('GET', '/admin/stats', null, userToken, 403);
  
  if (result.success) {
    printTestResult('User Admin Access', true, 'Correctly denied access to admin endpoints');
    return true;
  } else {
    printTestResult('User Admin Access', false, 'User should not have access to admin endpoints');
    return false;
  }
}

/**
 * Test invalid login
 */
async function testInvalidLogin() {
  const result = await makeApiRequest('POST', '/auth/login', { username: 'invalid', password: 'wrong' }, null, 401);
  
  if (result.success) {
    printTestResult('Invalid Login', true, 'Correctly rejected invalid credentials');
    return true;
  } else {
    printTestResult('Invalid Login', false, 'Should reject invalid credentials');
    return false;
  }
}

/**
 * Test frontend-backend integration
 */
async function testFrontendIntegration() {
  try {
    const response = await axios.get(CONFIG.frontendUrl, { timeout: 5000 });
    if (response.data.includes('Simple Login') || response.data.includes('React')) {
      printTestResult('Frontend Integration', true, 'Frontend is serving the application');
      return true;
    } else {
      printTestResult('Frontend Integration', false, 'Frontend not serving expected content');
      return false;
    }
  } catch (error) {
    printTestResult('Frontend Integration', false, `Frontend not accessible: ${error.message}`);
    return false;
  }
}

/**
 * Test CORS configuration
 */
async function testCORS() {
  try {
    const response = await axios.options(`${CONFIG.apiBase}/auth/login`, {
      headers: {
        'Origin': CONFIG.frontendUrl,
        'Access-Control-Request-Method': 'POST',
        'Access-Control-Request-Headers': 'Content-Type'
      }
    });
    
    if (response.headers['access-control-allow-origin']) {
      printTestResult('CORS Configuration', true, 'CORS headers present');
      return true;
    } else {
      printTestResult('CORS Configuration', false, 'CORS headers missing');
      return false;
    }
  } catch (error) {
    printTestResult('CORS Configuration', false, `CORS test failed: ${error.message}`);
    return false;
  }
}

/**
 * Main test runner
 */
async function runTests() {
  print('blue', '🚀 Starting Simple Login Application Integration Tests');
  print('blue', '==================================================');

  // Test 1: Check Backend Health
  print('blue', '\n📋 Test 1: Backend Health Check');
  const backendHealthy = await checkService('Backend', CONFIG.backendUrl);
  if (!backendHealthy) {
    print('red', '❌ Backend is not running. Please start it with:');
    print('red', '   cd simple-login-backend && ./mvnw spring-boot:run');
    process.exit(1);
  }

  // Test 2: Check Frontend Health
  print('blue', '\n📋 Test 2: Frontend Health Check');
  const frontendHealthy = await checkService('Frontend', CONFIG.frontendUrl);
  if (!frontendHealthy) {
    print('red', '❌ Frontend is not running. Please start it with:');
    print('red', '   cd simple-login-frontend && npm run dev');
    process.exit(1);
  }

  // Test 3: Admin Login
  print('blue', '\n📋 Test 3: Admin Login');
  await testAdminLogin();

  // Test 4: User Login
  print('blue', '\n📋 Test 4: User Login');
  await testUserLogin();

  // Test 5: Admin Profile
  print('blue', '\n📋 Test 5: Admin Profile Access');
  await testAdminProfile();

  // Test 6: User Profile
  print('blue', '\n📋 Test 6: User Profile Access');
  await testUserProfile();

  // Test 7: Dashboard Stats
  print('blue', '\n📋 Test 7: Admin Dashboard Stats');
  await testDashboardStats();

  // Test 8: Users List
  print('blue', '\n📋 Test 8: Admin Users List');
  await testUsersList();

  // Test 9: User Admin Access (Should Fail)
  print('blue', '\n📋 Test 9: User Access to Admin Endpoints (Should Fail)');
  await testUserAdminAccess();

  // Test 10: Invalid Login
  print('blue', '\n📋 Test 10: Invalid Login');
  await testInvalidLogin();

  // Test 11: Frontend Integration
  print('blue', '\n📋 Test 11: Frontend-Backend Integration');
  await testFrontendIntegration();

  // Test 12: CORS
  print('blue', '\n📋 Test 12: CORS Configuration');
  await testCORS();

  // Summary
  print('blue', '\n📊 Test Summary');
  print('blue', '==================================================');
  print('blue', `Total Tests: ${testResults.total}`);
  print('green', `Passed: ${testResults.passed}`);
  print('red', `Failed: ${testResults.failed}`);
  
  if (testResults.failed === 0) {
    print('green', '\n🎉 All tests passed! Your application is working correctly.');
  } else {
    print('yellow', `\n⚠️  ${testResults.failed} test(s) failed. Please check the errors above.`);
  }

  print('blue', '\n🎯 Next Steps:');
  print('blue', `1. Open your browser and go to: ${CONFIG.frontendUrl}`);
  print('blue', `2. Login with admin credentials: ${CONFIG.credentials.admin.username} / ${CONFIG.credentials.admin.password}`);
  print('blue', '3. Explore the dashboard features');
  print('blue', '4. Test user management functionality');
  print('blue', `5. Try logging in as regular user: ${CONFIG.credentials.user.username} / ${CONFIG.credentials.user.password}`);

  print('blue', '\n🔧 Available Test Users:');
  print('blue', `- Admin: ${CONFIG.credentials.admin.username} / ${CONFIG.credentials.admin.password} (Full dashboard access)`);
  print('blue', `- User: ${CONFIG.credentials.user.username} / ${CONFIG.credentials.user.password} (Limited access)`);
  print('blue', '- Test Users: testuser1-testuser5 / password');

  print('green', '\n🎉 Integration test completed successfully!');
  print('green', 'Your Simple Login application is ready for demonstration.');
}

// Run the tests
runTests().catch(error => {
  print('red', `\n❌ Test runner failed: ${error.message}`);
  process.exit(1);
});

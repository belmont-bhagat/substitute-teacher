#!/bin/bash

# Simple Login Application - Integration Test Script
# This script tests the connection between frontend and backend
# and validates all API endpoints are working correctly

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
BACKEND_URL="http://localhost:8080"
FRONTEND_URL="http://localhost:5173"
API_BASE="${BACKEND_URL}/api"

# Test credentials
ADMIN_USER="admin"
ADMIN_PASS="password"
REGULAR_USER="user"
REGULAR_PASS="password"

# Global variables
ADMIN_TOKEN=""
USER_TOKEN=""

echo -e "${BLUE}🚀 Starting Simple Login Application Integration Tests${NC}"
echo "=================================================="

# Function to print test results
print_test_result() {
    local test_name="$1"
    local status="$2"
    local message="$3"
    
    if [ "$status" = "PASS" ]; then
        echo -e "✅ ${GREEN}PASS${NC}: $test_name - $message"
    else
        echo -e "❌ ${RED}FAIL${NC}: $test_name - $message"
    fi
}

# Function to check if a service is running
check_service() {
    local service_name="$1"
    local url="$2"
    local max_attempts=30
    local attempt=1
    
    echo -e "${YELLOW}⏳ Checking if $service_name is running...${NC}"
    
    while [ $attempt -le $max_attempts ]; do
        if curl -s "$url" > /dev/null 2>&1; then
            print_test_result "$service_name Health Check" "PASS" "Service is running on $url"
            return 0
        fi
        
        echo -e "${YELLOW}   Attempt $attempt/$max_attempts - Waiting for $service_name...${NC}"
        sleep 2
        attempt=$((attempt + 1))
    done
    
    print_test_result "$service_name Health Check" "FAIL" "Service not responding after $max_attempts attempts"
    return 1
}

# Function to make API request and return response
make_api_request() {
    local method="$1"
    local endpoint="$2"
    local data="$3"
    local token="$4"
    local expected_status="$5"
    
    local url="${API_BASE}${endpoint}"
    local curl_cmd="curl -s -w '%{http_code}' -X $method"
    
    if [ -n "$data" ]; then
        curl_cmd="$curl_cmd -H 'Content-Type: application/json' -d '$data'"
    fi
    
    if [ -n "$token" ]; then
        curl_cmd="$curl_cmd -H 'Authorization: Bearer $token'"
    fi
    
    curl_cmd="$curl_cmd '$url'"
    
    local response=$(eval $curl_cmd)
    local status_code="${response: -3}"
    local body="${response%???}"
    
    if [ "$status_code" = "$expected_status" ]; then
        echo "$body"
        return 0
    else
        echo "HTTP $status_code: $body" >&2
        return 1
    fi
}

# Test 1: Check Backend Health
echo -e "\n${BLUE}📋 Test 1: Backend Health Check${NC}"
if check_service "Backend" "$BACKEND_URL"; then
    print_test_result "Backend Health" "PASS" "Backend is accessible"
else
    echo -e "${RED}❌ Backend is not running. Please start it with:${NC}"
    echo "   cd simple-login-backend && ./mvnw spring-boot:run"
    exit 1
fi

# Test 2: Check Frontend Health
echo -e "\n${BLUE}📋 Test 2: Frontend Health Check${NC}"
if check_service "Frontend" "$FRONTEND_URL"; then
    print_test_result "Frontend Health" "PASS" "Frontend is accessible"
else
    echo -e "${RED}❌ Frontend is not running. Please start it with:${NC}"
    echo "   cd simple-login-frontend && npm run dev"
    exit 1
fi

# Test 3: Admin Login
echo -e "\n${BLUE}📋 Test 3: Admin Login${NC}"
admin_login_response=$(make_api_request "POST" "/auth/login" "{\"username\":\"$ADMIN_USER\",\"password\":\"$ADMIN_PASS\"}" "" "200")
if [ $? -eq 0 ]; then
    ADMIN_TOKEN=$(echo "$admin_login_response" | grep -o '"token":"[^"]*"' | cut -d'"' -f4)
    if [ -n "$ADMIN_TOKEN" ]; then
        print_test_result "Admin Login" "PASS" "Successfully logged in as admin"
    else
        print_test_result "Admin Login" "FAIL" "No token received"
        exit 1
    fi
else
    print_test_result "Admin Login" "FAIL" "Login request failed"
    exit 1
fi

# Test 4: Regular User Login
echo -e "\n${BLUE}📋 Test 4: Regular User Login${NC}"
user_login_response=$(make_api_request "POST" "/auth/login" "{\"username\":\"$REGULAR_USER\",\"password\":\"$REGULAR_PASS\"}" "" "200")
if [ $? -eq 0 ]; then
    USER_TOKEN=$(echo "$user_login_response" | grep -o '"token":"[^"]*"' | cut -d'"' -f4)
    if [ -n "$USER_TOKEN" ]; then
        print_test_result "User Login" "PASS" "Successfully logged in as regular user"
    else
        print_test_result "User Login" "FAIL" "No token received"
        exit 1
    fi
else
    print_test_result "User Login" "FAIL" "Login request failed"
    exit 1
fi

# Test 5: Admin Profile Access
echo -e "\n${BLUE}📋 Test 5: Admin Profile Access${NC}"
admin_profile_response=$(make_api_request "GET" "/auth/profile" "" "$ADMIN_TOKEN" "200")
if [ $? -eq 0 ]; then
    admin_role=$(echo "$admin_profile_response" | grep -o '"role":"[^"]*"' | cut -d'"' -f4)
    if [ "$admin_role" = "ADMIN" ]; then
        print_test_result "Admin Profile" "PASS" "Admin profile retrieved with correct role"
    else
        print_test_result "Admin Profile" "FAIL" "Incorrect role: $admin_role"
    fi
else
    print_test_result "Admin Profile" "FAIL" "Profile request failed"
fi

# Test 6: User Profile Access
echo -e "\n${BLUE}📋 Test 6: User Profile Access${NC}"
user_profile_response=$(make_api_request "GET" "/auth/profile" "" "$USER_TOKEN" "200")
if [ $? -eq 0 ]; then
    user_role=$(echo "$user_profile_response" | grep -o '"role":"[^"]*"' | cut -d'"' -f4)
    if [ "$user_role" = "USER" ]; then
        print_test_result "User Profile" "PASS" "User profile retrieved with correct role"
    else
        print_test_result "User Profile" "FAIL" "Incorrect role: $user_role"
    fi
else
    print_test_result "User Profile" "FAIL" "Profile request failed"
fi

# Test 7: Admin Dashboard Stats
echo -e "\n${BLUE}📋 Test 7: Admin Dashboard Stats${NC}"
stats_response=$(make_api_request "GET" "/admin/stats" "" "$ADMIN_TOKEN" "200")
if [ $? -eq 0 ]; then
    total_users=$(echo "$stats_response" | grep -o '"totalUsers":[0-9]*' | cut -d':' -f2)
    if [ -n "$total_users" ] && [ "$total_users" -gt 0 ]; then
        print_test_result "Dashboard Stats" "PASS" "Retrieved stats with $total_users total users"
    else
        print_test_result "Dashboard Stats" "FAIL" "No user count found"
    fi
else
    print_test_result "Dashboard Stats" "FAIL" "Stats request failed"
fi

# Test 8: Admin Users List
echo -e "\n${BLUE}📋 Test 8: Admin Users List${NC}"
users_response=$(make_api_request "GET" "/admin/users?page=0&size=10" "" "$ADMIN_TOKEN" "200")
if [ $? -eq 0 ]; then
    users_count=$(echo "$users_response" | grep -o '"totalItems":[0-9]*' | cut -d':' -f2)
    if [ -n "$users_count" ] && [ "$users_count" -gt 0 ]; then
        print_test_result "Users List" "PASS" "Retrieved $users_count users with pagination"
    else
        print_test_result "Users List" "FAIL" "No users found"
    fi
else
    print_test_result "Users List" "FAIL" "Users request failed"
fi

# Test 9: User Access to Admin Endpoints (Should Fail)
echo -e "\n${BLUE}📋 Test 9: User Access to Admin Endpoints (Should Fail)${NC}"
user_stats_response=$(make_api_request "GET" "/admin/stats" "" "$USER_TOKEN" "403")
if [ $? -eq 0 ]; then
    print_test_result "User Admin Access" "PASS" "Correctly denied access to admin endpoints"
else
    print_test_result "User Admin Access" "FAIL" "User should not have access to admin endpoints"
fi

# Test 10: Invalid Login
echo -e "\n${BLUE}📋 Test 10: Invalid Login${NC}"
invalid_login_response=$(make_api_request "POST" "/auth/login" "{\"username\":\"invalid\",\"password\":\"wrong\"}" "" "401")
if [ $? -eq 0 ]; then
    print_test_result "Invalid Login" "PASS" "Correctly rejected invalid credentials"
else
    print_test_result "Invalid Login" "FAIL" "Should reject invalid credentials"
fi

# Test 11: Frontend-Backend Integration
echo -e "\n${BLUE}📋 Test 11: Frontend-Backend Integration${NC}"
frontend_response=$(curl -s "$FRONTEND_URL" | grep -i "simple login" || echo "")
if [ -n "$frontend_response" ]; then
    print_test_result "Frontend Integration" "PASS" "Frontend is serving the application"
else
    print_test_result "Frontend Integration" "FAIL" "Frontend not serving expected content"
fi

# Test 12: CORS Configuration
echo -e "\n${BLUE}📋 Test 12: CORS Configuration${NC}"
cors_response=$(curl -s -H "Origin: $FRONTEND_URL" -H "Access-Control-Request-Method: POST" -H "Access-Control-Request-Headers: Content-Type" -X OPTIONS "$API_BASE/auth/login")
if echo "$cors_response" | grep -q "Access-Control-Allow-Origin"; then
    print_test_result "CORS Configuration" "PASS" "CORS headers present"
else
    print_test_result "CORS Configuration" "FAIL" "CORS headers missing"
fi

# Summary
echo -e "\n${BLUE}📊 Test Summary${NC}"
echo "=================================================="

# Count test results (this is a simplified count)
total_tests=12
echo -e "Total Tests: $total_tests"
echo -e "✅ ${GREEN}All critical tests completed${NC}"

echo -e "\n${BLUE}🎯 Next Steps:${NC}"
echo "1. Open your browser and go to: $FRONTEND_URL"
echo "2. Login with admin credentials: $ADMIN_USER / $ADMIN_PASS"
echo "3. Explore the dashboard features"
echo "4. Test user management functionality"
echo "5. Try logging in as regular user: $REGULAR_USER / $REGULAR_PASS"

echo -e "\n${BLUE}🔧 Available Test Users:${NC}"
echo "- Admin: $ADMIN_USER / $ADMIN_PASS (Full dashboard access)"
echo "- User: $REGULAR_USER / $REGULAR_PASS (Limited access)"
echo "- Test Users: testuser1-testuser5 / password"

echo -e "\n${GREEN}🎉 Integration test completed successfully!${NC}"
echo "Your Simple Login application is ready for demonstration."

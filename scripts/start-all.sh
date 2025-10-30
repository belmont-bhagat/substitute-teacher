#!/bin/bash

# Simple Login Application - Start All Services
# This script starts all services (MongoDB, Backend, Frontend)

set -e

echo "🚀 Starting Simple Login Application"
echo "=================================="
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Load environment variables
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
    print_status "Loaded environment variables from .env"
else
    print_warning "No .env file found. Using default values."
fi

# Start MongoDB
start_mongodb() {
    print_status "Starting MongoDB..."
    
    if command -v docker &> /dev/null; then
        # Check if MongoDB container is already running
        if docker ps | grep -q simple-login-mongodb; then
            print_status "MongoDB container is already running"
        else
            # Start MongoDB container using docker-compose
            docker-compose up -d mongodb
            print_success "MongoDB started with Docker Compose"
        fi
    else
        print_warning "Docker not available. Please start MongoDB manually."
        echo "  - macOS: brew services start mongodb-community"
        echo "  - Ubuntu: sudo systemctl start mongodb"
    fi
    
    # Wait for MongoDB to be ready
    print_status "Waiting for MongoDB to be ready..."
    sleep 3
}

# Start Backend
start_backend() {
    print_status "Starting Spring Boot backend..."
    
    cd "${BACKEND_FOLDER:-simple-login-backend}"
    
    # Set Java environment to use Java 21
    if [ -d "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home" ]; then
        export JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
        export PATH="$JAVA_HOME/bin:$PATH"
        print_status "Using Java 21 from Homebrew"
    elif [ ! -z "$JAVA_HOME" ]; then
        export JAVA_HOME
        export PATH="$JAVA_HOME/bin:$PATH"
    fi
    
    # Set JWT secret
    if [ ! -z "$AUTH_JWT_SECRET" ]; then
        export AUTH_JWT_SECRET
    else
        export AUTH_JWT_SECRET="default-jwt-secret-key-change-this-in-production"
    fi
    
    # Start backend in background
    nohup ./mvnw spring-boot:run > ../logs/backend.log 2>&1 &
    BACKEND_PID=$!
    echo $BACKEND_PID > ../logs/backend.pid
    
    print_success "Backend started (PID: $BACKEND_PID)"
    print_status "Backend logs: logs/backend.log"
    
    cd ..
    
    # Wait for backend to be ready
    print_status "Waiting for backend to be ready..."
    sleep 10
}

# Start Frontend
start_frontend() {
    print_status "Starting React frontend..."
    
    cd "${FRONTEND_FOLDER:-simple-login-frontend}"
    
    # Start frontend in background
    nohup npm run dev > ../logs/frontend.log 2>&1 &
    FRONTEND_PID=$!
    echo $FRONTEND_PID > ../logs/frontend.pid
    
    print_success "Frontend started (PID: $FRONTEND_PID)"
    print_status "Frontend logs: logs/frontend.log"
    
    cd ..
    
    # Wait for frontend to be ready
    print_status "Waiting for frontend to be ready..."
    sleep 5
}

# Create logs directory
create_logs_dir() {
    if [ ! -d logs ]; then
        mkdir -p logs
        print_status "Created logs directory"
    fi
}

# Check if services are running
check_services() {
    print_status "Checking service status..."
    
    # Check MongoDB
    if command -v docker &> /dev/null; then
        if docker ps | grep -q simple-login-mongodb; then
            print_success "MongoDB: Running"
        else
            print_error "MongoDB: Not running"
        fi
    else
        print_warning "MongoDB: Docker not available, status unknown"
    fi
    
    # Check Backend
    if [ -f logs/backend.pid ]; then
        BACKEND_PID=$(cat logs/backend.pid)
        if ps -p $BACKEND_PID > /dev/null 2>&1; then
            print_success "Backend: Running (PID: $BACKEND_PID)"
        else
            print_error "Backend: Not running"
        fi
    else
        print_error "Backend: PID file not found"
    fi
    
    # Check Frontend
    if [ -f logs/frontend.pid ]; then
        FRONTEND_PID=$(cat logs/frontend.pid)
        if ps -p $FRONTEND_PID > /dev/null 2>&1; then
            print_success "Frontend: Running (PID: $FRONTEND_PID)"
        else
            print_error "Frontend: Not running"
        fi
    else
        print_error "Frontend: PID file not found"
    fi
}

# Main function
main() {
    create_logs_dir
    
    start_mongodb
    echo ""
    
    start_backend
    echo ""
    
    start_frontend
    echo ""
    
    check_services
    echo ""
    
    print_success "🎉 All services started successfully!"
    echo ""
    echo "🌐 Application URLs:"
    echo "  Frontend: http://localhost:5173"
    echo "  Backend API: http://localhost:8080"
    echo "  MongoDB: mongodb://localhost:27017"
    echo ""
    echo "📋 Default Login Credentials:"
    echo "  Username: admin"
    echo "  Password: password"
    echo ""
    echo "📊 Service Management:"
    echo "  View logs: tail -f logs/backend.log logs/frontend.log"
    echo "  Stop services: npm run stop"
    echo "  Restart: npm run stop && npm start"
    echo ""
    echo "🧪 API Testing:"
    echo "  Import postman/Simple-Login.postman_collection.json into Postman"
    echo "  Set base_url environment variable to http://localhost:8080"
}

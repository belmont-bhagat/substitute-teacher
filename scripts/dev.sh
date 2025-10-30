#!/bin/bash

# Simple Login Application - Development Mode
# This script starts services in development mode with hot reloading

set -e

echo "🔧 Starting Simple Login Application - Development Mode"
echo "======================================================"
echo ""

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

# Load environment variables
if [ -f .env ]; then
    export $(cat .env | grep -v '^#' | xargs)
    print_status "Loaded environment variables from .env"
fi

# Start MongoDB (if not already running)
start_mongodb() {
    print_status "Ensuring MongoDB is running..."
    
    if command -v docker &> /dev/null; then
        if ! docker ps | grep -q mongodb-simple-login; then
            docker run -d --name mongodb-simple-login -p 27017:27017 mongo:latest
            print_success "MongoDB started"
        else
            print_status "MongoDB already running"
        fi
    else
        print_status "Docker not available. Please ensure MongoDB is running manually."
    fi
}

# Start Backend in development mode
start_backend_dev() {
    print_status "Starting backend in development mode..."
    
    cd "${BACKEND_FOLDER:-simple-login-backend}"
    
    # Set Java environment
    if [ ! -z "$JAVA_HOME" ]; then
        export JAVA_HOME
        export PATH="$JAVA_HOME/bin:$PATH"
    fi
    
    # Set JWT secret
    if [ ! -z "$AUTH_JWT_SECRET" ]; then
        export AUTH_JWT_SECRET
    else
        export AUTH_JWT_SECRET="dev-jwt-secret-key-change-this-in-production"
    fi
    
    # Start with Spring Boot DevTools for hot reloading
    ./mvnw spring-boot:run &
    BACKEND_PID=$!
    echo $BACKEND_PID > ../logs/backend-dev.pid
    
    print_success "Backend started in development mode (PID: $BACKEND_PID)"
    
    cd ..
}

# Start Frontend in development mode
start_frontend_dev() {
    print_status "Starting frontend in development mode..."
    
    cd "${FRONTEND_FOLDER:-simple-login-frontend}"
    
    # Start with Vite dev server (hot reloading enabled by default)
    npm run dev &
    FRONTEND_PID=$!
    echo $FRONTEND_PID > ../logs/frontend-dev.pid
    
    print_success "Frontend started in development mode (PID: $FRONTEND_PID)"
    
    cd ..
}

# Create logs directory
create_logs_dir() {
    if [ ! -d logs ]; then
        mkdir -p logs
    fi
}

# Main function
main() {
    create_logs_dir
    
    start_mongodb
    echo ""
    
    start_backend_dev
    echo ""
    
    start_frontend_dev
    echo ""
    
    print_success "🎉 Development environment ready!"
    echo ""
    echo "🌐 Development URLs:"
    echo "  Frontend: http://localhost:5173 (with hot reload)"
    echo "  Backend API: http://localhost:8080 (with DevTools)"
    echo ""
    echo "🔄 Hot Reloading:"
    echo "  Frontend: Automatic on file changes"
    echo "  Backend: Automatic on class changes (Spring Boot DevTools)"
    echo ""
    echo "📊 Development Tools:"
    echo "  Backend logs: tail -f logs/backend-dev.log"
    echo "  Frontend logs: Check terminal output"
    echo "  Stop development: Ctrl+C or npm run stop"
    echo ""
    echo "🧪 Testing:"
    echo "  API Testing: Use Postman collection"
    echo "  Frontend Testing: Browser dev tools"
    echo ""
    
    # Keep script running and show logs
    print_status "Press Ctrl+C to stop all services..."
    
    # Wait for user interrupt
    trap 'echo ""; print_status "Stopping development services..."; npm run stop; exit 0' INT
    
    # Show live logs
    if [ -f logs/backend-dev.log ]; then
        tail -f logs/backend-dev.log &
    fi
    
    wait
}

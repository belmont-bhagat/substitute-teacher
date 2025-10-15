#!/bin/bash

# Simple Login Application - Stop All Services
# This script stops all running services

echo "🛑 Stopping Simple Login Application"
echo "==================================="
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

# Stop Frontend
stop_frontend() {
    print_status "Stopping React frontend..."
    
    if [ -f logs/frontend.pid ]; then
        FRONTEND_PID=$(cat logs/frontend.pid)
        if ps -p $FRONTEND_PID > /dev/null 2>&1; then
            kill $FRONTEND_PID
            print_success "Frontend stopped (PID: $FRONTEND_PID)"
        else
            print_warning "Frontend process not found"
        fi
        rm -f logs/frontend.pid
    else
        print_warning "Frontend PID file not found"
    fi
    
    # Kill any remaining processes on frontend port
    FRONTEND_PORT_PID=$(lsof -t -i:5173 2>/dev/null || true)
    if [ ! -z "$FRONTEND_PORT_PID" ]; then
        kill $FRONTEND_PORT_PID 2>/dev/null || true
        print_status "Killed process on port 5173"
    fi
}

# Stop Backend
stop_backend() {
    print_status "Stopping Spring Boot backend..."
    
    if [ -f logs/backend.pid ]; then
        BACKEND_PID=$(cat logs/backend.pid)
        if ps -p $BACKEND_PID > /dev/null 2>&1; then
            kill $BACKEND_PID
            print_success "Backend stopped (PID: $BACKEND_PID)"
        else
            print_warning "Backend process not found"
        fi
        rm -f logs/backend.pid
    else
        print_warning "Backend PID file not found"
    fi
    
    # Kill any remaining processes on backend port
    BACKEND_PORT_PID=$(lsof -t -i:8080 2>/dev/null || true)
    if [ ! -z "$BACKEND_PORT_PID" ]; then
        kill $BACKEND_PORT_PID 2>/dev/null || true
        print_status "Killed process on port 8080"
    fi
}

# Stop MongoDB
stop_mongodb() {
    print_status "Stopping MongoDB..."
    
    if command -v docker &> /dev/null; then
        if docker ps | grep -q mongodb-simple-login; then
            docker stop mongodb-simple-login
            docker rm mongodb-simple-login
            print_success "MongoDB container stopped and removed"
        else
            print_warning "MongoDB container not running"
        fi
    else
        print_warning "Docker not available. Please stop MongoDB manually."
        echo "  - macOS: brew services stop mongodb-community"
        echo "  - Ubuntu: sudo systemctl stop mongodb"
    fi
}

# Clean up logs
cleanup_logs() {
    print_status "Cleaning up log files..."
    
    if [ -d logs ]; then
        # Keep recent logs but clean up old ones
        find logs -name "*.log" -mtime +7 -delete 2>/dev/null || true
        print_success "Log cleanup completed"
    fi
}

# Main function
main() {
    stop_frontend
    echo ""
    
    stop_backend
    echo ""
    
    stop_mongodb
    echo ""
    
    cleanup_logs
    echo ""
    
    print_success "🛑 All services stopped successfully!"
    echo ""
    echo "📋 Next steps:"
    echo "  Start services: npm start"
    echo "  Development mode: npm run dev"
    echo "  Clean build: npm run clean"
}

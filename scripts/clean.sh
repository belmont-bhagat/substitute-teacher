#!/bin/bash

# Simple Login Application - Clean Script
# This script cleans all build artifacts and temporary files

echo "🧹 Cleaning Simple Login Application"
echo "==================================="
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

# Clean Backend
clean_backend() {
    print_status "Cleaning backend build artifacts..."
    
    cd simple-login-backend
    
    # Clean Maven build
    ./mvnw clean
    
    # Remove target directory
    rm -rf target/
    
    print_success "Backend cleaned"
    
    cd ..
}

# Clean Frontend
clean_frontend() {
    print_status "Cleaning frontend build artifacts..."
    
    cd simple-login-frontend
    
    # Remove build directories
    rm -rf dist/
    rm -rf node_modules/.vite/
    
    # Clean npm cache
    npm cache clean --force
    
    print_success "Frontend cleaned"
    
    cd ..
}

# Clean Logs
clean_logs() {
    print_status "Cleaning log files..."
    
    if [ -d logs ]; then
        rm -rf logs/*
        print_success "Log files cleaned"
    else
        print_status "No logs directory found"
    fi
}

# Clean Build Directory
clean_build() {
    print_status "Cleaning build directory..."
    
    if [ -d build ]; then
        rm -rf build/
        print_success "Build directory cleaned"
    else
        print_status "No build directory found"
    fi
}

# Clean Temporary Files
clean_temp() {
    print_status "Cleaning temporary files..."
    
    # Remove common temporary files
    find . -name "*.tmp" -delete 2>/dev/null || true
    find . -name "*.log" -delete 2>/dev/null || true
    find . -name ".DS_Store" -delete 2>/dev/null || true
    find . -name "Thumbs.db" -delete 2>/dev/null || true
    
    # Remove IDE files
    find . -name ".idea" -type d -exec rm -rf {} + 2>/dev/null || true
    find . -name ".vscode" -type d -exec rm -rf {} + 2>/dev/null || true
    find . -name "*.swp" -delete 2>/dev/null || true
    find . -name "*.swo" -delete 2>/dev/null || true
    
    print_success "Temporary files cleaned"
}

# Clean Docker
clean_docker() {
    print_status "Cleaning Docker containers and images..."
    
    if command -v docker &> /dev/null; then
        # Stop and remove MongoDB container
        docker stop mongodb-simple-login 2>/dev/null || true
        docker rm mongodb-simple-login 2>/dev/null || true
        
        # Remove unused images
        docker image prune -f 2>/dev/null || true
        
        print_success "Docker cleaned"
    else
        print_status "Docker not available"
    fi
}

# Clean Node Modules (optional)
clean_node_modules() {
    print_status "Cleaning node_modules directories..."
    
    # Clean root node_modules
    if [ -d node_modules ]; then
        rm -rf node_modules/
        print_success "Root node_modules cleaned"
    fi
    
    # Clean frontend node_modules
    if [ -d simple-login-frontend/node_modules ]; then
        rm -rf simple-login-frontend/node_modules/
        print_success "Frontend node_modules cleaned"
    fi
    
    # Clean mongo-auth-service node_modules
    if [ -d mongo-auth-service/node_modules ]; then
        rm -rf mongo-auth-service/node_modules/
        print_success "Mongo service node_modules cleaned"
    fi
}

# Main function
main() {
    clean_backend
    echo ""
    
    clean_frontend
    echo ""
    
    clean_logs
    echo ""
    
    clean_build
    echo ""
    
    clean_temp
    echo ""
    
    clean_docker
    echo ""
    
    # Ask about node_modules
    echo ""
    read -p "Do you want to remove node_modules directories? (y/N): " -n 1 -r
    echo ""
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        clean_node_modules
        echo ""
    fi
    
    print_success "🎉 Clean completed successfully!"
    echo ""
    echo "📋 What was cleaned:"
    echo "  ✅ Backend build artifacts"
    echo "  ✅ Frontend build artifacts"
    echo "  ✅ Log files"
    echo "  ✅ Build directory"
    echo "  ✅ Temporary files"
    echo "  ✅ Docker containers"
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "  ✅ Node modules"
    fi
    echo ""
    echo "🚀 Next steps:"
    echo "  1. Run 'npm run setup' to reinstall dependencies"
    echo "  2. Run 'npm start' to start services"
    echo "  3. Run 'npm run dev' for development"
}

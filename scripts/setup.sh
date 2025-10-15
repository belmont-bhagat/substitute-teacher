#!/bin/bash

# Simple Login Application - Complete Setup Script
# This script sets up the entire project environment

set -e  # Exit on any error

echo "🚀 Simple Login Application - Complete Setup"
echo "=========================================="
echo ""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
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

# Check prerequisites
check_prerequisites() {
    print_status "Checking prerequisites..."
    
    # Check Java
    if ! command -v java &> /dev/null; then
        print_error "Java is not installed. Please install Java 17 or higher."
        exit 1
    fi
    
    JAVA_VERSION=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2 | cut -d'.' -f1)
    if [ "$JAVA_VERSION" -lt 17 ]; then
        print_error "Java version $JAVA_VERSION is too old. Please install Java 17 or higher."
        exit 1
    fi
    print_success "Java $JAVA_VERSION found"
    
    # Check Node.js
    if ! command -v node &> /dev/null; then
        print_error "Node.js is not installed. Please install Node.js 18 or higher."
        exit 1
    fi
    
    NODE_VERSION=$(node -v | cut -d'v' -f2 | cut -d'.' -f1)
    if [ "$NODE_VERSION" -lt 18 ]; then
        print_error "Node.js version $NODE_VERSION is too old. Please install Node.js 18 or higher."
        exit 1
    fi
    print_success "Node.js $(node -v) found"
    
    # Check npm
    if ! command -v npm &> /dev/null; then
        print_error "npm is not installed."
        exit 1
    fi
    print_success "npm $(npm -v) found"
    
    # Check Docker (optional)
    if command -v docker &> /dev/null; then
        print_success "Docker found (optional for MongoDB)"
    else
        print_warning "Docker not found. You'll need to install MongoDB manually."
    fi
    
    # Check Git
    if ! command -v git &> /dev/null; then
        print_error "Git is not installed."
        exit 1
    fi
    print_success "Git $(git --version | cut -d' ' -f3) found"
}

# Setup environment variables
setup_environment() {
    print_status "Setting up environment variables..."
    
    # Create .env file if it doesn't exist
    if [ ! -f .env ]; then
        cat > .env << EOF
# Environment Configuration
NODE_ENV=development

# Backend Configuration
JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home
AUTH_JWT_SECRET=your-super-secure-jwt-secret-key-at-least-64-characters-long-change-this-in-production
MONGO_URI=mongodb://localhost:27017/simple_login

# Frontend Configuration
VITE_API_BASE_URL=http://localhost:8080/api
VITE_APP_TITLE=Simple Login Application

# Database Configuration
MONGO_DB_NAME=simple_login
MONGO_COLLECTION_USERS=users

# Server Ports
BACKEND_PORT=8080
FRONTEND_PORT=5173
MONGO_PORT=27017
EOF
        print_success "Created .env file"
    else
        print_status ".env file already exists"
    fi
    
    # Create .env.example
    cat > .env.example << EOF
# Environment Configuration Template
NODE_ENV=development

# Backend Configuration
JAVA_HOME=/path/to/your/java/home
AUTH_JWT_SECRET=your-super-secure-jwt-secret-key-at-least-64-characters-long
MONGO_URI=mongodb://localhost:27017/simple_login

# Frontend Configuration
VITE_API_BASE_URL=http://localhost:8080/api
VITE_APP_TITLE=Simple Login Application

# Database Configuration
MONGO_DB_NAME=simple_login
MONGO_COLLECTION_USERS=users

# Server Ports
BACKEND_PORT=8080
FRONTEND_PORT=5173
MONGO_PORT=27017
EOF
    print_success "Created .env.example template"
}

# Install backend dependencies
setup_backend() {
    print_status "Setting up backend dependencies..."
    
    cd simple-login-backend
    
    # Make Maven wrapper executable
    chmod +x mvnw
    
    # Install dependencies
    ./mvnw clean install -DskipTests
    print_success "Backend dependencies installed"
    
    cd ..
}

# Install frontend dependencies
setup_frontend() {
    print_status "Setting up frontend dependencies..."
    
    cd simple-login-frontend
    
    # Install dependencies
    npm install
    print_success "Frontend dependencies installed"
    
    cd ..
}

# Setup MongoDB
setup_mongodb() {
    print_status "Setting up MongoDB..."
    
    if command -v docker &> /dev/null; then
        print_status "Starting MongoDB with Docker..."
        docker run -d --name mongodb-simple-login -p 27017:27017 mongo:latest
        print_success "MongoDB started with Docker"
    else
        print_warning "Docker not available. Please install MongoDB manually:"
        echo "  - macOS: brew install mongodb-community"
        echo "  - Ubuntu: sudo apt-get install mongodb"
        echo "  - Or download from: https://www.mongodb.com/try/download/community"
    fi
}

# Create project documentation
create_documentation() {
    print_status "Creating project documentation..."
    
    # Create a comprehensive README
    cat > PROJECT-OVERVIEW.md << EOF
# Simple Login Application - Project Overview

## 🎯 Project Description
A complete full-stack authentication application demonstrating modern web development practices.

## 🏗️ Architecture
- **Backend**: Spring Boot with MongoDB
- **Frontend**: React with TypeScript
- **Database**: MongoDB
- **Authentication**: JWT tokens
- **API Testing**: Postman collection

## 🚀 Quick Start
1. Run \`npm run setup\` to install all dependencies
2. Run \`npm start\` to start all services
3. Open http://localhost:5173 in your browser

## 📁 Project Structure
\`\`\`
substitute-teacher/
├── simple-login-backend/     # Spring Boot API
├── simple-login-frontend/    # React application
├── mongo-auth-service/       # Optional Python service
├── postman/                  # API testing collection
├── scripts/                  # Automation scripts
└── docs/                     # Documentation
\`\`\`

## 🔧 Available Scripts
- \`npm run setup\` - Complete project setup
- \`npm start\` - Start all services
- \`npm run dev\` - Development mode
- \`npm run build\` - Build for production
- \`npm test\` - Run tests
- \`npm run clean\` - Clean build artifacts

## 📚 Documentation
- [API Documentation](postman/Simple-Login.postman_collection.json)
- [Backend README](simple-login-backend/README.md)
- [Frontend README](simple-login-frontend/README.md)

## 🛠️ Technologies Used
- Java 17+
- Spring Boot 3.1.5
- React 18.2.0
- TypeScript 5.9.3
- MongoDB
- JWT Authentication
- TailwindCSS
- Maven
- npm

## 📄 License
MIT License - see [LICENSE](LICENSE) file for details.
EOF
    
    print_success "Project documentation created"
}

# Main setup function
main() {
    echo "Starting complete project setup..."
    echo ""
    
    check_prerequisites
    echo ""
    
    setup_environment
    echo ""
    
    setup_backend
    echo ""
    
    setup_frontend
    echo ""
    
    setup_mongodb
    echo ""
    
    create_documentation
    echo ""
    
    print_success "🎉 Setup complete! Your project is ready to use."
    echo ""
    echo "Next steps:"
    echo "1. Review and update .env file with your settings"
    echo "2. Run 'npm start' to start all services"
    echo "3. Open http://localhost:5173 in your browser"
    echo "4. Use the Postman collection to test APIs"
    echo ""
    echo "For more information, see PROJECT-OVERVIEW.md"
}

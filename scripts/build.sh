#!/bin/bash

# Simple Login Application - Build Script
# This script builds the entire project for production

set -e

echo "🏗️ Building Simple Login Application"
echo "===================================="
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

# Create build directory
create_build_dir() {
    print_status "Creating build directory..."
    
    if [ -d build ]; then
        rm -rf build
    fi
    
    mkdir -p build/{backend,frontend,docs}
    print_success "Build directory created"
}

# Build Backend
build_backend() {
    print_status "Building Spring Boot backend..."
    
    cd "${BACKEND_FOLDER:-simple-login-backend}"
    
    # Set Java environment
    if [ ! -z "$JAVA_HOME" ]; then
        export JAVA_HOME
        export PATH="$JAVA_HOME/bin:$PATH"
    fi
    
    # Clean and build
    ./mvnw clean package -DskipTests
    
    # Copy JAR to build directory
    cp target/*.jar ../build/backend/
    
    print_success "Backend built successfully"
    print_status "JAR file: build/backend/"
    
    cd ..
}

# Build Frontend
build_frontend() {
    print_status "Building React frontend..."
    
    cd "${FRONTEND_FOLDER:-simple-login-frontend}"
    
    # Install dependencies
    npm ci
    
    # Build for production
    npm run build
    
    # Copy build to build directory
    cp -r dist/* ../build/frontend/
    
    print_success "Frontend built successfully"
    print_status "Static files: build/frontend/"
    
    cd ..
}

# Create deployment package
create_deployment_package() {
    print_status "Creating deployment package..."
    
    # Create deployment directory
    mkdir -p build/deployment
    
    # Copy backend JAR
    cp build/backend/*.jar build/deployment/
    
    # Copy frontend static files
    cp -r build/frontend build/deployment/
    
    # Copy configuration files
    cp .env.example build/deployment/.env.template
    cp docker-compose.yml build/deployment/ 2>/dev/null || true
    
    # Create deployment README
    cat > build/deployment/README.md << EOF
# Simple Login Application - Production Deployment

## 🚀 Quick Start

1. **Configure Environment**:
   \`\`\`bash
   cp .env.template .env
   # Edit .env with your production values
   \`\`\`

2. **Start MongoDB**:
   \`\`\`bash
   docker run -d --name mongodb -p 27017:27017 mongo:latest
   \`\`\`

3. **Start Backend**:
   \`\`\`bash
   java -jar simple-login-backend-*.jar
   \`\`\`

4. **Serve Frontend**:
   \`\`\`bash
   # Using nginx, Apache, or any static file server
   # Serve the frontend/ directory
   \`\`\`

## 📋 Production Checklist

- [ ] Update JWT secret in .env
- [ ] Configure MongoDB connection
- [ ] Set up HTTPS certificates
- [ ] Configure reverse proxy (nginx/Apache)
- [ ] Set up monitoring and logging
- [ ] Configure backup strategy
- [ ] Test all endpoints
- [ ] Set up CI/CD pipeline

## 🔧 Configuration

### Environment Variables
- \`AUTH_JWT_SECRET\`: JWT signing secret (64+ characters)
- \`MONGO_URI\`: MongoDB connection string
- \`NODE_ENV\`: Set to 'production'

### Ports
- Backend: 8080
- Frontend: Serve on port 80/443
- MongoDB: 27017

## 📊 Monitoring

- Backend logs: Check application logs
- Frontend: Browser dev tools
- Database: MongoDB logs
- System: Use monitoring tools (Prometheus, Grafana)

## 🛡️ Security

- Use HTTPS in production
- Set strong JWT secrets
- Configure CORS properly
- Use environment variables for secrets
- Regular security updates
EOF
    
    print_success "Deployment package created"
    print_status "Deployment files: build/deployment/"
}

# Generate documentation
generate_docs() {
    print_status "Generating documentation..."
    
    # Copy existing documentation
    cp README.md build/docs/ 2>/dev/null || true
    cp PROJECT-OVERVIEW.md build/docs/ 2>/dev/null || true
    
    # Create API documentation
    cat > build/docs/API.md << EOF
# Simple Login Application - API Documentation

## Base URL
\`http://localhost:8080/api\`

## Authentication
All endpoints except \`/login\` require a JWT token in the Authorization header:
\`Authorization: Bearer <jwt_token>\`

## Endpoints

### POST /login
Authenticate user and receive JWT token.

**Request Body:**
\`\`\`json
{
  "username": "admin",
  "password": "password"
}
\`\`\`

**Response:**
\`\`\`json
{
  "token": "eyJhbGciOiJIUzI1NiJ9..."
}
\`\`\`

### GET /profile
Get current user's profile information.

**Headers:**
\`Authorization: Bearer <jwt_token>\`

**Response:**
\`\`\`json
{
  "username": "admin",
  "role": "instructor"
}
\`\`\`

### GET /users
Get list of all users (requires authentication).

**Headers:**
\`Authorization: Bearer <jwt_token>\`

**Response:**
\`\`\`json
{
  "count": 11,
  "users": [
    {
      "id": "...",
      "username": "admin",
      "email": "admin@example.com",
      "role": "instructor"
    }
  ]
}
\`\`\`

## Error Responses

### 401 Unauthorized
\`\`\`json
{
  "error": "Unauthorized"
}
\`\`\`

### 400 Bad Request
\`\`\`json
{
  "error": "Invalid request"
}
\`\`\`
EOF
    
    print_success "Documentation generated"
    print_status "Documentation: build/docs/"
}

# Main function
main() {
    create_build_dir
    echo ""
    
    build_backend
    echo ""
    
    build_frontend
    echo ""
    
    create_deployment_package
    echo ""
    
    generate_docs
    echo ""
    
    print_success "🎉 Build completed successfully!"
    echo ""
    echo "📦 Build Artifacts:"
    echo "  Backend JAR: build/backend/"
    echo "  Frontend Static: build/frontend/"
    echo "  Deployment Package: build/deployment/"
    echo "  Documentation: build/docs/"
    echo ""
    echo "🚀 Next Steps:"
    echo "  1. Review build/deployment/README.md"
    echo "  2. Configure production environment"
    echo "  3. Deploy to your server"
    echo "  4. Test all functionality"
}

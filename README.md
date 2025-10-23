# Simple Login Application

A full-stack authentication application built with Spring Boot backend and React frontend, designed for educational purposes and teaching software engineering concepts.

## 🏗️ Architecture

- **Backend**: Spring Boot 3.1.5 with Java 17
- **Frontend**: React 18 with TypeScript and Vite
- **Database**: MongoDB with Docker
- **Authentication**: JWT-based authentication
- **Styling**: Tailwind CSS

## 🚀 Quick Start

### Prerequisites

- Java 17 or higher
- Node.js 18 or higher
- Docker and Docker Compose
- Maven (included via Maven Wrapper)

### Installation & Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd substitute-teacher
   ```

2. **Start all services**
   ```bash
   chmod +x scripts/start-all.sh
   ./scripts/start-all.sh
   ```

3. **Access the application**
   - Frontend: http://localhost:5173
   - Backend API: http://localhost:8080
   - MongoDB: mongodb://localhost:27017

### Default Credentials

- **Username**: `admin`
- **Password**: `password`

## 📁 Project Structure

```
substitute-teacher/
├── simple-login-backend/          # Spring Boot backend
│   ├── src/main/java/            # Java source code
│   ├── src/main/resources/       # Configuration files
│   ├── pom.xml                   # Maven dependencies
│   └── Dockerfile               # Docker configuration
├── simple-login-frontend/        # React frontend
│   ├── src/                     # React source code
│   ├── public/                  # Static assets
│   ├── package.json            # Node.js dependencies
│   └── vite.config.ts          # Vite configuration
├── postman/                     # API testing collection
│   └── Simple-Login.postman_collection.json
├── scripts/                     # Utility scripts
│   ├── start-all.sh            # Start all services
│   └── stop-all.sh             # Stop all services
├── docker-compose.yml          # Docker services configuration
├── Project Outline.md          # Project documentation
├── subsitute-teacher-ouline.md # Teaching plan
└── README.md                   # This file
```

## 🔧 Development

### Backend Development

```bash
cd simple-login-backend

# Set Java 17 (if needed)
export JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home

# Run the application
./mvnw spring-boot:run
```

### Frontend Development

```bash
cd simple-login-frontend

# Install dependencies
npm install

# Start development server
npm run dev
```

### Database

MongoDB runs in a Docker container. The database is automatically seeded with sample users on startup.

## 🧪 API Testing

Import the Postman collection from `postman/Simple-Login.postman_collection.json`:

1. Open Postman
2. Import the collection file
3. Set the `base_url` environment variable to `http://localhost:8080`
4. Run the requests in order:
   - Login (POST /api/login)
   - Profile (GET /api/profile)
   - List Users (GET /api/users)

## 📚 API Endpoints

### Authentication

- `POST /api/login` - User login
  - Body: `{"username": "admin", "password": "password"}`
  - Response: `{"token": "jwt-token"}`

- `GET /api/profile` - Get user profile
  - Headers: `Authorization: Bearer <token>`
  - Response: `{"username": "admin", "role": "instructor"}`

- `GET /api/users` - List all users
  - Headers: `Authorization: Bearer <token>`
  - Response: `{"users": [...], "count": 11}`

## 🎓 Teaching Materials

This project includes comprehensive teaching materials:

- **Project Outline.md**: Detailed project architecture and implementation plan
- **subsitute-teacher-ouline.md**: 75-minute teaching session plan
- **Postman Collection**: Ready-to-use API testing collection

### Teaching Session Overview

The teaching plan covers:
1. Backend architecture (Spring Boot + MongoDB + JWT)
2. Postman API demonstration
3. Frontend walkthrough (React + TypeScript)
4. Live dashboard development with Cursor AI

## 🛠️ Scripts

- `./scripts/start-all.sh` - Start all services (MongoDB, Backend, Frontend)
- `./scripts/stop-all.sh` - Stop all services and clean up

## 🔒 Security Features

- JWT-based authentication
- Password hashing with BCrypt
- CORS configuration
- Input validation
- Role-based access control

## 📝 Environment Variables

Create a `.env` file in the root directory:

```env
# JWT Configuration
AUTH_JWT_SECRET=your-super-secure-jwt-secret-key-at-least-64-characters-long

# MongoDB Configuration
MONGO_URI=mongodb://localhost:27017/simple_login

# Java Configuration
JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home
```

## 🐳 Docker Support

The application includes Docker configuration for easy deployment:

```bash
# Start only MongoDB
docker-compose up -d mongodb

# Start all services
docker-compose up -d
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Troubleshooting

### Common Issues

1. **Java Version Issues**
   - Ensure Java 17 is installed and JAVA_HOME is set correctly
   - Use: `export JAVA_HOME=/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home`

2. **MongoDB Connection Issues**
   - Ensure Docker is running
   - Check if MongoDB container is running: `docker ps | grep mongodb`

3. **Port Conflicts**
   - Backend: 8080
   - Frontend: 5173
   - MongoDB: 27017

4. **Frontend Not Connecting to Backend**
   - Check if backend is running on port 8080
   - Verify CORS configuration in backend

### Getting Help

- Check the logs in the `logs/` directory
- Review the Postman collection for API testing
- Refer to the teaching materials for detailed explanations

---

**Built for educational purposes** - Perfect for teaching full-stack development, authentication, and modern web technologies.
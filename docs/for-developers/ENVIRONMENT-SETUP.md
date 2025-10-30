# 🔧 Environment Configuration (Advanced)

**For Students**: You don't need this! The app works great with default settings.

**For Developers**: If you need to customize environment variables, follow this guide.

---

## 📝 Environment Variables

The application can be configured using environment variables or a `.env` file.

### Option 1: Command Line (Recommended for Students)

```bash
# Set environment variables inline
cd my-backend
./mvnw spring-boot:run -Dspring-boot.run.jvmArguments="-Dauth.jwt.secret=your-secret"
```

### Option 2: .env File (Recommended for Developers)

1. Copy the template:
```bash
cp docs/for-developers/env.template.example .env
```

2. Edit `.env` with your values

3. Export variables in your shell:
```bash
source .env
```

4. Run the application (variables are now available)

---

## 🔑 Available Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `AUTH_JWT_SECRET` | JWT signing secret | (from application.properties) |
| `MONGO_URI` | MongoDB connection string | `mongodb://localhost:27017/simple_login` |
| `JAVA_HOME` | Java installation path | System default |
| `VITE_API_BASE_URL` | Frontend API endpoint | `http://localhost:8080/api` |
| `NODE_ENV` | Node environment | `development` |

---

## 📁 Template File

See [env.template.example](./env.template.example) for a complete example.

---

## ⚠️ Security Notes

- ❌ **NEVER** commit `.env` to git (it's in `.gitignore`)
- ✅ **DO** use strong secrets in production
- ✅ **DO** use environment-specific values
- ✅ **DO** rotate secrets regularly

---

**Most users don't need custom environment variables!**  
The defaults work great for learning and local development.


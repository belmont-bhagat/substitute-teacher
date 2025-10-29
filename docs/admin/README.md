# 🔧 Admin & Setup

**Repository administration and configuration**

## 📋 Admin Documentation

### [PROTECTION-SETUP.md](./PROTECTION-SETUP.md)
Complete guide for setting up GitHub branch protection rules and repository security.

### [CONTRIBUTING.md](./CONTRIBUTING.md)
Guidelines for contributors - how to fork, create PRs, and contribute to the project.

---

## 🔒 Repository Protection

This repository has branch protection enabled:
- ✅ Direct pushes to main are blocked
- ✅ All changes require pull request reviews
- ✅ At least 1 approval required before merging
- ✅ Only owner can merge PRs

See [PROTECTION-SETUP.md](./PROTECTION-SETUP.md) for detailed setup instructions.

---

## 🤝 Contributing

For contribution guidelines, see [CONTRIBUTING.md](./CONTRIBUTING.md).

**Quick summary:**
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a Pull Request
5. Wait for approval

---

## 🛠️ Maintenance Tasks

### Update Dependencies
```bash
# Backend (Maven)
cd simple-login-backend
./mvnw versions:display-dependency-updates

# Frontend (npm)
cd simple-login-frontend
npm outdated
```

### Clean Build Artifacts
```bash
# Backend
cd simple-login-backend
./mvnw clean

# Frontend
cd simple-login-frontend
rm -rf node_modules dist
npm install
```

---

## 📊 Monitoring

- Check logs in `logs/` directory
- Monitor Docker containers: `docker ps`
- Check application health: `curl http://localhost:8080/api/login`

---

**For repository owners and maintainers only.**


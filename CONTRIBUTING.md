# Contributing to Simple Login Application

## 🤝 Guidelines for Contributing

Thank you for your interest in contributing to this project! Please follow these guidelines to ensure a smooth collaboration.

## 📝 How to Contribute

### 1. Getting Started

1. **Fork the repository** to your GitHub account
2. **Clone your fork** locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/substitute-teacher.git
   ```
3. **Create a branch** for your changes:
   ```bash
   git checkout -b feature/your-feature-name
   ```

### 2. Making Changes

- Follow the existing code style and conventions
- Write clear, concise commit messages
- Add comments where necessary
- Test your changes thoroughly
- Update documentation as needed

### 3. Submitting Changes

1. **Commit your changes**:
   ```bash
   git add .
   git commit -m "Description of your changes"
   ```

2. **Push to your fork**:
   ```bash
   git push origin feature/your-feature-name
   ```

3. **Create a Pull Request** on GitHub
   - Provide a clear description of your changes
   - Explain why the changes are needed
   - Reference any related issues

## 🔒 Approval Process

### Branch Protection Rules

This repository is protected to ensure code quality and project integrity:

- **Main branch is protected**: Direct pushes to `main` are not allowed
- **Pull Request Required**: All changes must go through a pull request
- **Review Required**: All pull requests require approval before merging
- **Status Checks**: Automated checks must pass before merging

### What This Means for Contributors

1. ✅ You can create forks and branches freely
2. ✅ You can make changes in your own fork
3. ✅ You can submit pull requests
4. ⚠️ Pull requests require owner approval to merge
5. ⚠️ You cannot force push or delete branches

### For Project Owner

Only the repository owner can:
- Merge pull requests
- Delete protected branches
- Force push to main
- Modify branch protection settings
- Add collaborators

## 📋 Code of Conduct

### Do's ✅

- Be respectful and considerate
- Provide constructive feedback
- Help others learn
- Follow the project structure
- Write clear documentation

### Don'ts ❌

- Don't bypass the approval process
- Don't force push to protected branches
- Don't delete or modify existing functionality without discussion
- Don't submit incomplete or untested code
- Don't ignore project conventions

## 🐛 Reporting Issues

If you find a bug or have a suggestion:

1. Check if the issue already exists
2. Create a new issue with:
   - Clear description
   - Steps to reproduce (if it's a bug)
   - Expected vs actual behavior
   - Environment details

## 💡 Feature Requests

For new features:

1. Create an issue to discuss the feature first
2. Wait for owner approval before starting work
3. Submit a pull request with the implementation
4. Ensure all tests pass

## 🔍 Code Review Process

1. **Submit your PR**: Create a pull request
2. **Wait for review**: Owner will review your changes
3. **Address feedback**: Make requested changes
4. **Get approval**: Owner approves the PR
5. **Merge**: Owner merges the changes

## 📚 Project Structure

Please maintain the existing project structure:

```
substitute-teacher/
├── simple-login-backend/     # Backend code (Spring Boot)
├── simple-login-frontend/    # Frontend code (React)
├── postman/                  # API testing files
├── scripts/                  # Automation scripts
├── docs/                     # Documentation
└── README.md                 # Main documentation
```

## 🧪 Testing

Before submitting changes:

1. Run the test suite:
   ```bash
   npm test
   ```

2. Test manually:
   ```bash
   npm start
   # Test the changes in the running application
   ```

3. Ensure all tests pass

## 📝 Documentation

- Update README.md for significant changes
- Document new features
- Update API documentation if endpoints change
- Add inline comments for complex code

## 🙏 Thank You!

Your contributions are valued and appreciated. By following these guidelines, you help maintain the quality and integrity of the project.

---

**Note**: This project is designed for educational purposes. All contributions should maintain the project's educational value and code quality standards.
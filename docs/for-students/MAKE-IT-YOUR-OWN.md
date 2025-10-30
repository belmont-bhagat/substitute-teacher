# 🎨 Make This Project Your Own

## 📝 Quick Planning Sheet
```
Backend folder: ______________________ (ex: backend-demo)
Frontend folder: ______________________ (ex: frontend-demo)
Java package:   ______________________ (ex: edu.belmont.demo)
```

---

## 🚀 Quick Start (Personalize and Run)

From your project root, run:
```bash
bash scripts/setup-my-project.sh <backend-folder> <frontend-folder> <java.package>
# ex:
bash scripts/setup-my-project.sh backend-demo frontend-demo edu.belmont.demo

bash scripts/dev.sh
```
- Frontend: http://localhost:5173
- Backend:  http://localhost:8080/api
- Default login: admin / password

---

## 👩‍💻 Workflow in 3 Steps

1. **Customize**: Replace the arguments above with your own names.
2. **(Re)Run at any time:** Change your mind? Re-run the script as often as you want with new names.
3. **Troubleshoot:**
    - If anything fails: `bash scripts/stop-all.sh && bash scripts/dev.sh`
    - If you typo’d your folder/package, just run the setup script with corrected values.

---

## 💡 Want full control? (rare)
For manual refactoring, or for advanced Maven/Git customization, see [Advanced Dev Docs](../for-developers/ENVIRONMENT-SETUP.md) or ask your instructor!

---

**That’s it: full customization in one script. Enjoy building!**


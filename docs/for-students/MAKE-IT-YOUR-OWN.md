# 🚦 How to Make This Project Your Own

## 1. 📁 Rename Your Folders FIRST

Choose your project folder names:
- Backend:  `YOUR-BACKEND-NAME`   (ex: `login-backend`)
- Frontend: `YOUR-FRONTEND-NAME`  (ex: `student-app`)

From the project root, **RENAME FIRST**:
```bash
# Example – change to YOUR names!
git mv backend-demo your-backend-folder
git mv frontend-demo your-frontend-folder
```
- Use ONLY hyphens/underscores (e.g. `my-backend`), **NO dots or spaces!**
- Confirm folder names after renaming: run `ls` in project root.

---

## 2. 🛠️ Run the Customization Script
```bash
bash scripts/setup-my-project.sh your-backend-folder your-frontend-folder edu.yourorg.yourname

bash scripts/dev.sh
```
- Fill in: **your backend folder, your frontend folder, and your Java package** (ex: `edu.school.yourname`).

---

## 3. ✅ Open Your App
- Frontend: http://localhost:5173
- Backend: http://localhost:8080/api
- Default login: admin / password

---

## 4. 🆘 Troubleshooting
- If you see `No such file or directory`, you likely skipped the folder rename or mistyped a folder name—**fix the names, then re-run the script**.
- If anything fails, run:
  ```bash
  bash scripts/stop-all.sh
  bash scripts/dev.sh
  ```
- Want to only change Java package? Use the current folder names in the script and change only the last argument.

---

## 🙋 Advanced Setup
For full manual refactoring or advanced options: [Advanced Dev Docs](../for-developers/ENVIRONMENT-SETUP.md) or ask your instructor!

---

# 📝 Quick Planning Sheet
```
Backend folder: ______________________ (ex: your-backend-folder)
Frontend folder: ______________________ (ex: your-frontend-folder)
Java package:   ______________________ (ex: edu.school.yourname)
```


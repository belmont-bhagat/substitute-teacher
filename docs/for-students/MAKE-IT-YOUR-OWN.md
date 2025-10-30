# 🚦 Make It Yours (do this first)

## 1) Rename folders (do this first)
From the project root, replace CURRENT_* with your actual current folder names and run:
```bash
git mv CURRENT_BACKEND_NAME your-backend-folder
git mv CURRENT_FRONTEND_NAME your-frontend-folder
```
Rules:
- Folder names use hyphens/underscores (no spaces/dots).

## 2) Update pom.xml manually
Open `your-backend-folder/pom.xml` and change the project coordinates:
- Change `<groupId>` to your Java package (example: `edu.school.demo`)
- Change `<artifactId>` to your backend folder name (example: `your-backend-folder`)
Do NOT change anything inside `<parent> ... </parent>`.

Example (before → after):
```xml
<project>
  <parent>
    <!-- keep parent as-is -->
  </parent>
  <groupId>edu.school.demo</groupId>
  <artifactId>your-backend-folder</artifactId>
  <!-- ... -->
</project>
```

## 3) Apply Java package (one command)
Now run the script to update Java packages/imports and finish wiring:
```bash
bash scripts/setup-my-project.sh your-backend-folder your-frontend-folder edu.school.demo
```
This will:
- Move Java files under the new package and update `package`/`import` lines
- Update Spring `spring.application.name`
- Update Docker Compose dev config where needed
- Create/update `.env` with your folder names
- Install frontend dependencies

Start the app with hot reload:
```bash
bash scripts/dev.sh
```

---

### Tip
To keep your current folder names (no rename), pass those exact names in step 3.

---

## 4) Verify in these exact places (takes 30 seconds)
- `your-backend-folder/pom.xml`
  - `<groupId>` should be: `edu.yourorg.yourname`
- `your-backend-folder/src/main/java/.../*.java`
  - First line should be: `package edu.yourorg.yourname;`
- Browser
  - Frontend: http://localhost:5173
  - API: http://localhost:8080/api
  - Login: `admin` / `password`

---

## 5) Troubleshooting (fast fixes)
- “No such file or directory”: double-check the two folder names you passed into the script.
- Change package only: re-run the same command but keep the same folder names and change only the last argument.
- Stuck? Restart services:
  ```bash
  bash scripts/stop-all.sh
  bash scripts/dev.sh
  ```

---

Need more control? See: [Advanced Dev Docs](../for-developers/ENVIRONMENT-SETUP.md)


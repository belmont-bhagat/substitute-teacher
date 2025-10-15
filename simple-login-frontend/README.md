# Simple Login Frontend (React + TypeScript + Vite)

A minimal, modern UI for the Simple Login demo. Connects to the Spring Boot backend and demonstrates basic auth with JWT and local token storage. Uses a neutral TailwindCSS theme.

## Requirements
- Node.js 18+
- Backend running at `http://localhost:8080`

## Quick Start
```bash
# in one terminal: backend
cd ../simple-login-backend
./mvnw spring-boot:run

# in another terminal: frontend
cd simple-login-frontend
npm install
npm run dev
```
- App: `http://localhost:5173`
- Dev proxy: `/api/*` -> `http://localhost:8080`

## Environment
Create `.env.development` and `.env.production` if needed. Defaults are fine for local:
```
VITE_API_BASE_URL=/api
VITE_PORT=5173
```

## Scripts
- `npm run dev` – start dev server
- `npm run build` – production build
- `npm run preview` – preview production build

## Project Structure
```
simple-login-frontend/
  src/
    lib/
      api.ts          # Axios instance with auth header
      auth.ts         # getToken, setToken, clearToken
    pages/
      LoginPage.tsx   # /login page (neutral gray theme)
      ProfilePage.tsx # /profile page (neutral gray theme)
    main.tsx          # Router setup
    index.css         # TailwindCSS imports
  vite.config.ts       # dev proxy to backend
  tailwind.config.js   # Tailwind config
```

## Auth Flow
- `/login` -> POST `/api/login` with `{ username, password }`
  - On success: save `token` in localStorage and redirect to `/profile`
  - On error: display message
- `/profile` -> GET `/api/profile` with `Authorization: Bearer <token>`
  - If unauthorized: clear token and redirect to `/login`

## Notes
- UI uses neutral gray accents for consistency; customize Tailwind if desired.
- For production builds, configure a concrete `VITE_API_BASE_URL` and serve the built assets behind your reverse proxy or static host.

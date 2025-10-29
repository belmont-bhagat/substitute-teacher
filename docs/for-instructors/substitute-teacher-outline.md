## Substitute Teaching Plan: Simple Login Project and Cursor Demo

- Course: Software Engineering (Intro/Intermediate)
- Instructor: Pranish Bhagat
- Date: October 23, 2025
- Duration: 75 minutes
- Location/Modality: [Room / Virtual]
- Materials: `simple-login-backend/` (Spring Boot), `simple-login-frontend/` (React + Vite + TS), Postman collection `postman/Simple-Login.postman_collection.json`, `Project Outline.md`, Cursor editor

## Learning Objectives
- Understand the project architecture and frameworks (Spring Boot, MongoDB, React).
- Execute and observe the backend authentication flow via Postman.
- Navigate the frontend authentication flow and protected routes.
- Observe a live addition of a dashboard route using Cursor-assisted development.

## Session Agenda (with Timings)
- 0–5 min: Opening and Context
  - Set expectations: guided tour + small live build.
  - Present `Project Outline.md` to frame the session.
- 5–15 min: Existing Backend Overview (Spring Boot + MongoDB + JWT)
  - Show structure: `simple-login-backend/` and key classes: `AuthController`, `AuthService`, `JwtService`, `UserRepository`, `UserDocument`, config in `JwtConfig`, `application.properties`.
  - Explain JWT, roles (USER/ADMIN), and CORS.
- 15–30 min: Postman Demo — Login and Profile Flow
  - Open `postman/Simple-Login.postman_collection.json`.
  - Demo: POST `/api/login` with sample credentials; copy/inspect JWT.
  - Demo: GET `/api/profile` with Bearer token; show success and an error case (missing/expired token).
  - Emphasize request/response structure, validation, and error handling.
- 30–45 min: Frontend Walkthrough (React + Vite + TS + Tailwind)
  - Show structure: `simple-login-frontend/`
    - Pages: `src/pages/LoginPage.tsx`, `src/pages/ProfilePage.tsx`, `src/pages/UsersDashboard.tsx`
    - Layout: `src/components/AuthLayout.tsx`
    - Auth helpers: `src/lib/api.ts`, `src/lib/auth.ts`
  - Explain protected routes, token storage, and API calls.
  - Quick run: Vite dev server; login → redirect to profile; demonstrate 401 redirect behavior.
- 45–65 min: Live Build — Add Dashboard Landing Page (Cursor Demo)
  - Goal: Create `/dashboard` route with a simple shell and metric cards; link to `UsersDashboard`.
  - Steps (narrate while Cursor assists):
    - Create `src/pages/DashboardHome.tsx` with a minimal layout (header + 2–3 metric cards).
    - Add route for `/dashboard` within protected layout (`AuthLayout`).
    - Add a nav link or button from existing pages to `/dashboard`.
    - If time permits, call a lightweight endpoint (or mock in component) to populate a "Users count" card.
  - Teaching focus:
    - Write concise prompts in Cursor to generate boilerplate safely.
    - Review diffs, keep names explicit, and match project patterns.
    - Run/lint, refresh browser, verify route works and is gated.
- 65–72 min: Q&A and Quick Checks
  - Ask students to summarize the auth flow end-to-end.
  - Quick quiz: "Where is JWT created?" "Which file injects auth headers?"
- 72–75 min: Wrap-Up
  - Revisit `Project Outline.md` milestones (M1–M5).
  - Suggest next steps: add one metric to `DashboardHome.tsx` and submit a PR.

## Demonstration Scripts and Talking Points
- Backend (10 min)
  - Show `AuthController` endpoints and how JWT validation gates `/api/profile`.
  - Explain `JwtService` for signing/validation; confirm expiry settings in `JwtConfig` and allowed origins in `application.properties`.
  - Mention `UserRepository` and the unique email index in `UserDocument`.
- Postman (15 min)
  - Login: highlight request body and expected response (JWT).
  - Profile: attach Bearer token in the Authorization header; discuss 401 scenarios.
- Frontend (15 min)
  - `src/lib/api.ts`: base URL and attaching the token.
  - `src/lib/auth.ts`: token storage/access; logout path.
  - `AuthLayout.tsx`: route protection and redirect to login.
  - `LoginPage.tsx` flow: submit → store token → navigate.
  - `ProfilePage.tsx` flow: fetch profile → render user info.

## Live Build Plan (Cursor-Assisted)
- Create `DashboardHome.tsx`: simple layout + cards (e.g., "Welcome", "Users", "Profile" link).
- Update routes to include `/dashboard` under `AuthLayout`.
- Link to `UsersDashboard.tsx`.
- If time: add a small API call (or mocked data) to populate one card; explain handling loading/error states.

## Setup Checklist (Pre-Class)
- Start backend: run Spring Boot app (verify `application.properties`).
- Start frontend: Vite dev server (`http://localhost:5173`).
- Postman: import `postman/Simple-Login.postman_collection.json`.
- Test credentials: ensure one working user; have email/password ready.
- Editor: open Cursor at repo root; keep `Project Outline.md` accessible.

## Assessment and Participation
- In-class activity: demonstrate the login and profile flow (live or via screenshare/recorded steps).
- Group discussion: brainstorm ways to extend the dashboard, such as adding new cards linking to Profile or Users.
- Exit prompt: each student identifies one security feature (like CORS, JWT verification, or password hashing) and describes its purpose in the system.


## Contingencies
- Backend fails to start: demonstrate Postman with screenshots or explain responses with mock JSON.
- Time constraints: skip metrics fetch; still deliver the `/dashboard` route and shell.

## Deliverables for Students
- `Project Outline.md` (architecture reference)
- Postman collection: `postman/Simple-Login.postman_collection.json`
- Key files to review: `AuthController`, `JwtService`, `AuthLayout.tsx`, `LoginPage.tsx`, `ProfilePage.tsx`, `UsersDashboard.tsx`

## Project Outline

> **⚠️ IMPORTANT NOTE**: This outline describes the **full-featured version** of the project. The **no-dashboard branch** is a simplified version focusing only on authentication (login + profile). See [for-developers/overview.md](../for-developers/overview.md) for what's included in the no-dashboard branch.

### Full Version Features
- Backend with simple login features (Spring Boot + MongoDB + JWT)
- Frontend with simple login features (React + Vite + TypeScript + Tailwind)
- Dashboard capabilities (role-based access, users management)
- Cross-cutting: testing, CI/CD, environments, security, observability, deployment

### No-Dashboard Branch Features
- Backend: Authentication with JWT (Spring Boot + MongoDB)
- Frontend: Login page + Profile page only (React + Vite + TypeScript + Tailwind)
- No dashboard, no user management UI

## Frameworks Used (and Why)

- Spring Boot (Java) for the backend
  - Robust security (Spring Security), production-ready defaults, strong ecosystem.
  - Great fit for JWT-based auth and role-based access control.
- MongoDB for data storage
  - Flexible schema for users and audit-style events; easy to seed and index.
- React + Vite + TypeScript for the frontend
  - Fast development experience, strong typing, simple routing; Tailwind for rapid, consistent styling.

## Current Repository Components

- Backend (Spring Boot): `custom-backend-name/`   # e.g. api-auth
  - Key classes: `AuthController`, `AuthService`, `JwtService`, `UserRepository`, `UserDocument`, `DataSeeder`.
  - Config: `application.properties`, `JwtConfig`.
- Frontend (React/Vite/TS): `custom-frontend-name/`   # e.g. portal-ui
  - Key components/pages: `LoginPage.tsx`, `ProfilePage.tsx`, `UsersDashboard.tsx`, `AuthLayout.tsx`.
  - API helpers: `src/lib/api.ts`, `src/lib/auth.ts`.
- Reference Node/TS auth example: `mongo-auth-service/`.

## Part 1: Backend – Simple Login Features (Spring Boot)

### Requirements
- User login with email and password
- Password hashing (bcrypt)
- JWT-based authentication (access tokens)
- Basic roles: USER, ADMIN
- CORS configuration for the frontend origin
- Input validation and error handling

### Data Model (MongoDB)
- `UserDocument` fields
  - `id`, `email` (unique), `passwordHash`, `displayName`
  - `roles: [USER|ADMIN]`
  - `createdAt`, `updatedAt`, `lastLoginAt`

### API Endpoints
- POST `/api/login` – authenticate user and return JWT
- GET `/api/profile` – return current user profile (requires JWT)

### Files to Add/Edit
- `custom-backend-name/src/main/java/.../controller/AuthController.java`
  - Ensure endpoints: login, profile.
- `custom-backend-name/src/main/java/.../service/AuthService.java`
  - Credential verification, password hashing checks, last login update.
- `custom-backend-name/src/main/java/.../service/JwtService.java`
  - JWT generation/validation, expiry handling.
- `custom-backend-name/src/main/java/.../model/UserDocument.java`
  - Fields above + unique index on email.
- `custom-backend-name/src/main/java/.../config/JwtConfig.java`
  - Secret, expiry, JWT filter if used; enable CORS.
- `custom-backend-name/src/main/resources/application.properties`
  - Mongo URI, JWT secret, CORS origins.

### Security & Validation
- Hash passwords with bcrypt.
- Validate email and password on login.
- Guard `/api/profile` with JWT.
- Configure CORS for `http://localhost:5173` (Vite default).

### Testing
- Unit: `AuthService`, `JwtService`.
- Integration: login → profile; invalid credentials; unauthorized access.

## Part 2: Frontend – Simple Login Features (React + Vite + TS)

### Requirements
- Pages: Login, Profile
- Protected routes with `AuthLayout`
- Auth state (context) and token storage
- API client with auth header
- Form validation and user feedback

### Screens & Flows
- `LoginPage.tsx`
  - Email/password form → call `/api/login` → store token → redirect to Profile.
- `ProfilePage.tsx`
  - Fetch `/api/profile` → display user data; handle 401 by redirecting to Login.

### Files to Add/Edit
- `custom-frontend-name/src/lib/api.ts`
  - Base URL, auth header injection, error handling.
- `custom-frontend-name/src/lib/auth.ts`
  - Token storage/getter, login/logout helpers.
- `custom-frontend-name/src/components/*`
  - Reuse `Input`, `Button`, `Card`, and `AuthLayout` for protected routing.
- `custom-frontend-name/src/pages/LoginPage.tsx`
  - Submit to backend; navigate on success; show errors.
- `custom-frontend-name/src/pages/ProfilePage.tsx`
  - Fetch protected profile; display fields.

### Testing
- Component tests for `LoginPage` form validation.
- Integration: successful login redirects; unauthorized guard redirects to login.

## Part 3: Dashboard Capabilities

### Goals
- Role-based access: USER vs ADMIN
- Dashboard shell with sidebar/header
- Users management module for admins

### Backend Additions
- Endpoints (ADMIN)
  - GET `/api/admin/users?query=&page=&size=`
  - PATCH `/api/admin/users/{id}` body: `{ roles, isActive }`
- Endpoints (USER/ADMIN)
  - PATCH `/api/user/profile` (update `displayName`)
  - POST `/api/user/change-password`
- Security
  - Method-level security annotations for role guards
  - Pagination and validation on admin endpoints

### Frontend Additions
- Routes
  - `/dashboard` (protected shell)
  - `/dashboard/users` (ADMIN)
  - `/dashboard/profile` (USER/ADMIN)
  - `/dashboard/settings` (USER/ADMIN)
- Components
  - `DashboardLayout` (sidebar, header, breadcrumbs)
  - `UsersTable` with search, sort, pagination
  - Forms for profile and password change
- State & Data
  - Centralized API client with auth header
  - Role-aware navigation rendering

### Non-Functional
- Lazy-load dashboard routes
- Accessible navigation and forms
- Consistent theming via Tailwind

## Cross-Cutting Concerns

- Configuration & environments
  - `.env` values for backend URL, JWT secret, Mongo URI; never commit secrets.
  - Distinct CORS origins per environment.
- Observability
  - Structured logs with correlation IDs; basic request/response metrics.
- Security hardening
  - HTTPS in production, HSTS, secure headers via gateway.
  - Rate limiting on auth endpoints; lockout after repeated failures.
- Data & storage
  - Index `email`; define backup/retention policy.
- Quality & CI/CD
  - Lint, unit/integration tests in CI; build artifacts.
  - Containerize backend/frontend; deploy via Docker Compose or PaaS.

## Milestones (With File-Level Guidance)

- M1: Backend auth MVP
  - Edit: `AuthController`, `AuthService`, `JwtService`, `JwtConfig`, `UserDocument`, `application.properties`.
  - Add: login/profile endpoints; bcrypt; CORS.
- M2: Frontend auth MVP
  - Edit: `src/lib/api.ts`, `src/lib/auth.ts`, `LoginPage.tsx`, `ProfilePage.tsx`, `AuthLayout.tsx`.
  - Add: protected routing; token handling; error states.
- M3: RBAC + admin endpoints
  - Edit: add roles/guards; implement `/api/admin/users` list + update.
- M4: Dashboard UI
  - Add: `DashboardLayout`, `UsersTable`; routes under `/dashboard/*`.
- M5: Hardening, tests, docs, CI/CD
  - Add: tests coverage; Dockerfiles; README updates; environment documentation.

## Next Steps

- Confirm backend base URL and CORS settings for local development.
- Verify login and profile flow via the Postman collection.
- Connect frontend login to backend and protect profile route.
- Build out users management screen and role-based navigation.

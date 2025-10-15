# mongo-auth-service (optional)

A lightweight Node/Express service that validates credentials against MongoDB and returns the same token format the frontend expects (for demo parity). This service is optional; the Spring backend already integrates directly with MongoDB.

## Requirements
- Node.js 18+
- MongoDB (Docker or local)

## Quick Start
```bash
# 1) Ensure Mongo is running
# Docker:
docker run -d --name mongo -p 27017:27017 mongo:7

# 2) Install and seed
cd mongo-auth-service
npm install
npm run seed   # creates user admin/password

# 3) Run service
npm run dev    # listens on :4000
```

## Endpoints
- `POST /api/login` -> `{ token: 'fake-jwt-token' }` if credentials valid, otherwise 401

## When to use
- Only if you want to keep auth verification separate from the Spring backend. For the main demo, prefer using the backend’s integrated Mongo + JWT auth.

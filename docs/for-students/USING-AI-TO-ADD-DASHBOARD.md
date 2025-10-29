# 🤖 Using AI to Add a Dashboard Feature

**For Students: Learn how to use AI assistants to extend your project**

This guide will help you use AI coding assistants (like Claude in Cursor, ChatGPT, or GitHub Copilot) to add a dashboard feature to your login application.

> **Important**: AI is a powerful tool, but it's not perfect! This guide will help you work effectively with AI and handle common issues that arise.

---

## ⚡ Quick Start (3 Steps)

1) Open your project and start an AI chat (Cursor or ChatGPT)
2) Copy the prompt below and replace [YOUR-PACKAGE-NAME]
3) Apply changes one file at a time, build and test after each step

> Tip: Make a Git commit BEFORE you start. If something breaks, you can easily roll back.

---

## 📋 Before You Start

### ✅ Prerequisites

Make sure you have:
- [ ] Completed the basic project setup (GETTING-STARTED.md)
- [ ] Successfully customized your package (MAKE-IT-YOUR-OWN.md)
- [ ] A working login application (can login and see profile)
- [ ] Your code committed to Git (so you can revert if needed!)

### 🎯 What You'll Build

A **Student Dashboard** that shows:
- Welcome message with student name
- List of enrolled courses
- Recent grades/assignments
- Profile information

---

## 🤖 Recommended AI Tools

### Option 1: Cursor AI (Recommended for this project)
- **Model**: Claude 3.5 Sonnet (by Anthropic)
- **Best for**: Full-stack development, explaining code
- **Access**: Built into Cursor IDE
- **Cost**: Free tier available, Pro subscription for unlimited

### Option 2: ChatGPT
- **Model**: GPT-4 or GPT-4 Turbo (by OpenAI)
- **Best for**: Planning, debugging, code snippets
- **Access**: https://chat.openai.com
- **Cost**: Free tier (GPT-3.5), Plus subscription for GPT-4

### Option 3: GitHub Copilot
- **Model**: GPT-4 based (by OpenAI)
- **Best for**: Code completion, suggestions while typing
- **Access**: VS Code or Cursor extension
- **Cost**: Student license available (free with GitHub Student Pack)

### Option 4: Claude.ai
- **Model**: Claude 3.5 Sonnet (by Anthropic)
- **Best for**: Complex reasoning, code review
- **Access**: https://claude.ai
- **Cost**: Free tier, Pro subscription available

---

## 📝 The Dashboard Feature Prompt

Copy and paste this prompt to your AI assistant. **Customize the parts in [brackets]** with your own information!

### 🎯 Complete Prompt Template

```
I'm a student working on a Spring Boot login application with a React frontend. 
I want to add a Student Dashboard feature after login.

PROJECT DETAILS:
- Backend: Spring Boot 3.5.7 + Java 21 + MongoDB
- Frontend: React 18 + TypeScript + Vite
- Current Package: [YOUR-PACKAGE-NAME, e.g., edu.belmont.pranish]
- Authentication: JWT tokens (already working)

CURRENT STATE:
- Users can login successfully
- After login, they see a basic profile page
- We have three endpoints: /api/login, /api/profile, /api/users

WHAT I WANT TO ADD:
A Student Dashboard page that shows:
1. Welcome message with student's name
2. List of enrolled courses (sample data is fine)
3. Current semester information
4. Recent grades/assignments (sample data)
5. A navigation menu to switch between Dashboard and Profile

REQUIREMENTS:
- Add a new backend endpoint: GET /api/dashboard
- Create a new React component: Dashboard.tsx
- The dashboard should be protected (require JWT authentication)
- Use the same styling as the existing Profile page
- Add navigation between Dashboard and Profile pages

PLEASE:
1. Show me the backend controller changes first
2. Then show me the frontend component
3. Explain how to test it
4. Tell me which files I need to create/modify

Can you help me implement this step by step?
```

---

## 🎓 How to Use This Prompt

### Step 1: Prepare Your AI Session

**If using Cursor AI:**
1. Open your project in Cursor
2. Press `Cmd/Ctrl + K` for chat
3. Make sure the AI can see your current files

**If using ChatGPT/Claude.ai:**
1. Open a new chat session
2. You'll need to share code snippets manually
3. Be ready to copy/paste files

### Step 2: Send the Prompt

1. Copy the template above
2. **Replace [YOUR-PACKAGE-NAME]** with your actual package name
3. Customize any other details to match your project
4. Paste and send to your AI

### Step 3: Follow the AI's Instructions

The AI will typically respond with:
1. Backend changes (Java controller)
2. Frontend changes (React components)
3. Testing instructions

**IMPORTANT**: Don't just copy-paste blindly! Read and understand each step.

---

## ⚠️ Common Problems & Solutions

> Expect that you may see some errors on the first try. That's normal. Use these fixes.

### Problem 1: AI Uses Wrong Package Names

**Symptom:**
```java
package com.example.demo;  // ❌ Wrong package!
```

**Solution:**
Tell the AI:
```
Please update the package name to [YOUR-PACKAGE-NAME] instead of com.example.demo
```

---

### Problem 2.5: AI Mentions Files or Folders You Don't Have

**Symptom:**
AI refers to paths like `src/app/router.tsx` or `services/UserService.java` that don't exist in your project.

**Solution:**
1. Ask the AI to adapt to your actual structure (show it your existing files)
2. Create missing files only when needed, in the correct folders
3. Use the existing patterns in this repo (e.g., `controller/`, `service/`, `model/`)

---

### Problem 2: Import Statements Don't Match

**Symptom:**
```java
import com.example.simpleloginbackend.model.User;  // ❌ Wrong!
```

**Solution:**
1. The AI might not know your exact package structure
2. Manually update the imports to match YOUR package
3. Use your IDE's auto-import feature (Alt+Enter in Cursor)

---

### Problem 3: AI Suggests Outdated Syntax

**Symptom:**
```java
@RequestMapping(value = "/api/dashboard", method = RequestMethod.GET)  // Old style
```

**Modern version:**
```java
@GetMapping("/api/dashboard")  // ✅ Better!
```

**Solution:**
- Use the modern version if you recognize it
- Or ask: "Can you use modern Spring Boot annotations like @GetMapping?"

---

### Problem 4: Frontend Code Uses Different State Management

**Symptom:**
AI suggests Redux when you're using React hooks, or vice versa.

**Solution:**
Tell the AI:
```
Please use React hooks (useState, useEffect) like the existing Profile component, 
not Redux or other state management.
```

---

### Problem 5: TypeScript Type Errors

**Symptom:**
```typescript
const user: User = response.data;  // Type 'User' doesn't exist
```

**Solution:**
1. Check if the AI defined the `User` type
2. If not, ask: "Can you show me the TypeScript interface definitions?"
3. Or define it yourself based on your API response

---

### Problem 6: API Endpoint Mismatch

**Symptom:**
Frontend calls `/dashboard` but backend has `/api/dashboard`

**Solution:**
Make sure the frontend uses the full path:
```typescript
const response = await fetch('http://localhost:8080/api/dashboard', {
  headers: { 'Authorization': `Bearer ${token}` }
});
```

---

### Problem 7: CORS Errors

**Symptom:**
```
Access to fetch at 'http://localhost:8080/api/dashboard' from origin 
'http://localhost:5173' has been blocked by CORS policy
```

**Solution:**
1. Check that your `CorsConfig.java` includes the new endpoint
2. Or add it to `SecurityConfig.java`:
```java
.requestMatchers("/api/dashboard").authenticated()
```

---

### Problem 8: MongoDB Model Doesn't Exist

**Symptom:**
AI creates code that expects a `Course` or `Grade` collection that you don't have.

**Solution:**
Tell the AI:
```
For now, please return sample/mock data instead of querying the database. 
I'll add real database models later.
```

---

### Problem 9: Build Fails After Adding Code

**Symptom:**
```
[ERROR] Failed to execute goal org.apache.maven.plugins:maven-compiler-plugin
```

**Solution:**
1. Clean and rebuild:
   ```bash
   ./mvnw clean compile
   ```
2. Check for missing imports or syntax errors
3. Share the error with the AI: "I'm getting this error: [paste error]"

---

### Problem 10: React Component Doesn't Show

**Symptom:**
You added the component but it doesn't appear in the browser.

**Solution:**
1. Check if you added the route in your React Router
2. Make sure you imported the component
3. Check browser console for errors (F12)

---

## 🎯 Step-by-Step Workflow

### Phase 1: Backend (Java)

1. **Ask AI to show backend changes first**
2. **Create new files** the AI suggests
3. **Modify existing files** carefully
4. **Build and test**:
   ```bash
   ./mvnw clean compile
   ./mvnw spring-boot:run
   ```
5. **Test with curl**:
   ```bash
   TOKEN=your-jwt-token
   curl -X GET http://localhost:8080/api/dashboard \
     -H "Authorization: Bearer $TOKEN"
   ```

### Phase 2: Frontend (React/TypeScript)

1. **Ask AI to show frontend changes**
2. **Create new components** (e.g., `Dashboard.tsx`)
3. **Update routing** if needed
4. **Test in browser**:
   ```bash
   cd simple-login-frontend
   npm run dev
   ```
5. **Check browser console** (F12) for errors

### Phase 3: Integration Testing

1. **Login** to get a token
2. **Navigate** to dashboard
3. **Verify data** shows correctly
4. **Test navigation** between pages

---

## 🧪 Testing Your Dashboard

### Manual Testing Checklist

- [ ] Backend starts without errors
- [ ] Frontend starts without errors
- [ ] Can login successfully
- [ ] Dashboard endpoint returns data (test with curl)
- [ ] Dashboard page loads in browser
- [ ] Data displays correctly
- [ ] Navigation works (Profile ↔ Dashboard)
- [ ] Logout still works
- [ ] No console errors in browser (F12)

### Sample Test Commands

**1. Test backend endpoint:**
```bash
# First login
TOKEN=$(curl -s -X POST http://localhost:8080/api/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"password"}' | grep -o '"token":"[^"]*' | cut -d'"' -f4)

# Then test dashboard
curl -X GET http://localhost:8080/api/dashboard \
  -H "Authorization: Bearer $TOKEN"
```

**Expected response:**
```json
{
  "studentName": "Admin User",
  "courses": [...],
  "semester": "Fall 2024",
  "recentGrades": [...]
}
```

---

## 💡 Tips for Working with AI

### ✅ DO:

1. **Be specific** - The more details you provide, the better
2. **Ask for explanations** - "Can you explain why we need this?"
3. **Request step-by-step** - "Show me one file at a time"
4. **Verify before applying** - Read the code, don't blindly copy
5. **Keep context** - Reference previous responses in the same chat
6. **Ask for tests** - "How can I test this?"
7. **Share errors** - Copy the full error message to the AI

### ❌ DON'T:

1. **Assume AI is always right** - It makes mistakes!
2. **Copy large blocks without understanding** - You'll get lost
3. **Mix different AI suggestions** - Stick with one approach
4. **Skip testing between steps** - Test after each change
5. **Forget to commit working code** - Commit before major changes
6. **Ignore warnings** - Red squiggly lines = problems

---

## 🔄 If Things Go Wrong

### Rollback Strategy

If the AI's code breaks your project:

1. **Check what changed:**
   ```bash
   git status
   git diff
   ```

2. **Revert if needed:**
   ```bash
   # Revert all changes
   git restore .
   
   # Or revert specific file
   git restore path/to/file.java
   ```

3. **Start over:**
   - Create a new chat with the AI
   - Be more specific this time
   - Ask for smaller steps

---

## 🎓 Learning Opportunity

### What You'll Learn

By working with AI on this feature, you'll understand:

- ✅ How to communicate technical requirements
- ✅ How to review and modify AI-generated code
- ✅ How Spring Boot controllers work
- ✅ How React components communicate with APIs
- ✅ How authentication flows work
- ✅ How to debug full-stack applications
- ✅ How to work with modern AI development tools

---

## 📚 Follow-Up Prompts

After getting the basic dashboard working, try these:

### Enhancement 1: Add Real Database Integration

```
Now that the dashboard works with sample data, can you help me:
1. Create a Course model in MongoDB
2. Create a CourseRepository
3. Update the dashboard endpoint to query real courses
Show me the code step by step.
```

### Enhancement 2: Add CRUD Operations

```
I want to add the ability to:
1. Add a new course
2. Remove a course
3. Update course information
Can you show me the backend endpoints and frontend forms needed?
```

### Enhancement 3: Improve UI

```
The dashboard works but looks basic. Can you help me:
1. Add cards for each course
2. Use icons for different course types
3. Make it more visually appealing with CSS
Please use Tailwind CSS like the rest of the app.
```

---

## 🆘 When to Ask for Help

Contact your instructor if:

- ❌ You've tried 3 different approaches and all fail
- ❌ The AI keeps giving you the same broken code
- ❌ You don't understand the fundamental concepts
- ❌ Your entire project is broken and Git won't help
- ❌ You've spent more than 2 hours stuck on one error

**It's OK to ask for help!** That's what instructors are for.

---

## ✅ Success Checklist

You've successfully used AI when you can:

- [ ] Explain what each part of the code does
- [ ] Modify the code to add small features yourself
- [ ] Debug basic errors without the AI
- [ ] Test your changes thoroughly
- [ ] Have working code committed to Git
- [ ] Demonstrate the feature to someone else

---

## 🎯 Next Steps

After completing the dashboard:

1. **Commit your work:**
   ```bash
   git add .
   git commit -m "Add student dashboard feature with AI assistance"
   git push
   ```

2. **Document what you learned** - Write notes for yourself

3. **Try adding another feature** - Use AI again, but with less help

4. **Review the code** - Go back and make sure you understand it all

---

## 📖 Additional Resources

### Understanding the Code

- **Spring Boot Controllers**: https://spring.io/guides/gs/rest-service/
- **React Hooks**: https://react.dev/reference/react
- **JWT Authentication**: https://jwt.io/introduction
- **MongoDB with Spring**: https://spring.io/guides/gs/accessing-data-mongodb/

### Working with AI

- **Prompt Engineering Guide**: https://www.promptingguide.ai/
- **Claude Documentation**: https://docs.anthropic.com/
- **GitHub Copilot Tips**: https://github.blog/developer-skills/

---

## 🎓 Remember

> **AI is a tool, not a replacement for learning!**

The goal is not just to get working code, but to **understand** how it works. Use AI to:
- Speed up development
- Learn new patterns
- Get unstuck
- See different approaches

But always:
- Read the code
- Test thoroughly  
- Understand before moving forward
- Ask "why?" not just "how?"

---

**Good luck building your dashboard!** 🚀

If you found this guide helpful, share what you learned with your classmates!

---

## 📝 Appendix: Sample Dashboard Response

Here's what a successful dashboard API response might look like:

```json
{
  "studentName": "John Smith",
  "studentId": "12345",
  "semester": "Fall 2024",
  "enrolledCourses": [
    {
      "courseId": "CS101",
      "courseName": "Introduction to Programming",
      "instructor": "Dr. Johnson",
      "credits": 3,
      "schedule": "MWF 10:00-11:00"
    },
    {
      "courseId": "MATH201",
      "courseName": "Calculus II",
      "instructor": "Prof. Williams",
      "credits": 4,
      "schedule": "TTH 13:00-14:30"
    }
  ],
  "recentGrades": [
    {
      "courseId": "CS101",
      "assignmentName": "Homework 3",
      "grade": "A",
      "points": "95/100",
      "date": "2024-10-15"
    },
    {
      "courseId": "MATH201",
      "assignmentName": "Quiz 2",
      "grade": "B+",
      "points": "87/100",
      "date": "2024-10-12"
    }
  ],
  "gpa": 3.75,
  "totalCredits": 45
}
```

This structure gives you a good template to work from!


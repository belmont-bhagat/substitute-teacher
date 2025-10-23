package com.example.simpleloginbackend.controller;

import com.example.simpleloginbackend.model.LoginRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import java.util.List;
import com.example.simpleloginbackend.service.AuthService;
import com.example.simpleloginbackend.service.JwtService;
import com.example.simpleloginbackend.model.UserDocument;

/**
 * REST Controller for handling authentication operations.
 * Provides endpoints for login and user profile retrieval.
 * CORS is enabled to allow requests from frontend development servers.
 */
@RestController
@RequestMapping("/api")
@CrossOrigin(origins = {"http://localhost:5173", "http://localhost:3000", "http://127.0.0.1:5173"})
public class AuthController {

    private final AuthService authService;
    private final JwtService jwtService;

    public AuthController(AuthService authService, JwtService jwtService) {
        this.authService = authService;
        this.jwtService = jwtService;
    }

    /**
     * Login endpoint that authenticates users based on username and password.
     * 
     * @param loginRequest The login credentials containing username and password
     * @return ResponseEntity with a token if credentials are valid, or an error message if invalid
     * 
     * Expected behavior:
     * - If username is "admin" and password is "password", returns 200 OK with a fake JWT token
     * - Otherwise, returns 401 Unauthorized with an error message
     */
    @PostMapping("/login")
    public ResponseEntity<Map<String, String>> login(@RequestBody LoginRequest loginRequest) {
        Map<String, String> response = new HashMap<>();

        boolean valid = authService.validateCredentials(loginRequest.getUsername(), loginRequest.getPassword());
        if (!valid) {
            response.put("error", "Invalid credentials");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }
        
        // Update last login timestamp
        authService.updateLastLogin(loginRequest.getUsername());
        
        String token = jwtService.issueToken(loginRequest.getUsername());
        response.put("token", token);
        return ResponseEntity.ok(response);
    }

    /**
     * Profile endpoint that returns user information for authenticated users.
     * 
     * @param authHeader The Authorization header containing the Bearer token
     * @return ResponseEntity with user profile if token is valid, or an error message if invalid
     * 
     * Expected behavior:
     * - If Authorization header contains "Bearer fake-jwt-token", returns 200 OK with user profile
     * - Otherwise, returns 401 Unauthorized with an error message
     */
    @GetMapping("/profile")
    public ResponseEntity<Map<String, String>> getProfile(
            @RequestHeader(value = "Authorization", required = false) String authHeader) {
        
        Map<String, String> response = new HashMap<>();
        
        // Check if the Authorization header is present and valid
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring("Bearer ".length());
            String subject = jwtService.validateAndGetSubject(token);
            if (subject != null) {
                // fetch role from DB if available
                String role = authService.getUser(subject).map(u -> u.getRole() != null ? u.getRole() : "instructor").orElse("instructor");
                response.put("username", subject);
                response.put("role", role);
                return ResponseEntity.ok(response);
            }
        }
        response.put("error", "Unauthorized");
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
    }

    /**
     * Users list endpoint that returns all users for authenticated users.
     * 
     * @param authHeader The Authorization header containing the Bearer token
     * @return ResponseEntity with list of users if token is valid, or an error message if invalid
     * 
     * Expected behavior:
     * - If Authorization header contains valid Bearer token, returns 200 OK with list of all users
     * - Otherwise, returns 401 Unauthorized with an error message
     */
    @GetMapping("/users")
    public ResponseEntity<Map<String, Object>> getAllUsers(
            @RequestHeader(value = "Authorization", required = false) String authHeader) {

        Map<String, Object> response = new HashMap<>();

        // Validate authentication
        if (authHeader == null || !authHeader.startsWith("Bearer ")) {
            response.put("error", "Unauthorized");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }

        String token = authHeader.substring("Bearer ".length());
        String subject = jwtService.validateAndGetSubject(token);
        if (subject == null) {
            response.put("error", "Invalid token");
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
        }

        // Get all users from database
        List<UserDocument> users = authService.getAllUsers();
        List<Map<String, String>> userList = users.stream()
                .map(user -> {
                    Map<String, String> userInfo = new HashMap<>();
                    userInfo.put("username", user.getUsername());
                    userInfo.put("role", user.getRole() != null ? user.getRole() : "instructor");
                    return userInfo;
                })
                .collect(java.util.stream.Collectors.toList());

        response.put("users", userList);
        response.put("count", userList.size());
        return ResponseEntity.ok(response);
    }

}


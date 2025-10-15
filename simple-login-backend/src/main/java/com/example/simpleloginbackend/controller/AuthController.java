package com.example.simpleloginbackend.controller;

import com.example.simpleloginbackend.model.LoginRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;
import com.example.simpleloginbackend.service.AuthService;
import com.example.simpleloginbackend.service.JwtService;

/**
 * REST Controller for handling authentication operations.
 * Provides endpoints for login and user profile retrieval.
 * CORS is enabled to allow requests from any origin (suitable for demo purposes).
 */
@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "*")
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
                response.put("username", subject);
                response.put("role", "instructor");
                return ResponseEntity.ok(response);
            }
        }
        response.put("error", "Unauthorized");
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(response);
    }

}


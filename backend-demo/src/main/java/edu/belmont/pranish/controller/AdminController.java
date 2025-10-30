package edu.belmont.demo.controller;

import edu.belmont.demo.model.UserDocument;
import edu.belmont.demo.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * Admin controller for user management operations.
 * Requires ADMIN role for all endpoints.
 */
@RestController
@RequestMapping("/api/admin")
@CrossOrigin(origins = {"http://localhost:5173", "http://localhost:3000", "http://127.0.0.1:5173"})
public class AdminController {

    @Autowired
    private AuthService authService;

    /**
     * Get all users with pagination and optional search query.
     * 
     * @param page Page number (0-based)
     * @param size Page size
     * @param query Optional search query for username
     * @return Paginated list of users
     */
    @GetMapping("/users")
    public ResponseEntity<Map<String, Object>> getAllUsers(
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "10") int size,
            @RequestParam(required = false) String query) {
        
        Pageable pageable = PageRequest.of(page, size);
        Page<UserDocument> usersPage = authService.getAllUsers(query, pageable);
        
        Map<String, Object> response = new HashMap<>();
        response.put("users", usersPage.getContent());
        response.put("currentPage", usersPage.getNumber());
        response.put("totalItems", usersPage.getTotalElements());
        response.put("totalPages", usersPage.getTotalPages());
        response.put("hasNext", usersPage.hasNext());
        response.put("hasPrevious", usersPage.hasPrevious());
        
        return ResponseEntity.ok(response);
    }

    /**
     * Update user roles and status.
     * 
     * @param id User ID
     * @param updateData Map containing role and isActive fields
     * @return Updated user document
     */
    @PatchMapping("/users/{id}")
    public ResponseEntity<UserDocument> updateUser(
            @PathVariable String id,
            @RequestBody Map<String, Object> updateData) {
        
        UserDocument updatedUser = authService.updateUser(id, updateData);
        if (updatedUser != null) {
            return ResponseEntity.ok(updatedUser);
        } else {
            return ResponseEntity.notFound().build();
        }
    }

    /**
     * Get dashboard statistics.
     * 
     * @return Map containing various user statistics
     */
    @GetMapping("/stats")
    public ResponseEntity<Map<String, Object>> getDashboardStats() {
        Map<String, Object> stats = authService.getUserStats();
        return ResponseEntity.ok(stats);
    }
}

package edu.belmont.demo.service;

import edu.belmont.demo.model.UserDocument;
import edu.belmont.demo.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.List;

@Service
public class AuthService {

    private final UserRepository userRepository;

    @Autowired
    public AuthService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public boolean validateCredentials(String username, String rawPassword) {
        Optional<UserDocument> userOpt = userRepository.findByUsername(username);
        if (userOpt.isEmpty()) {
            return false;
        }
        UserDocument user = userOpt.get();
        String hash = user.getPasswordHash();
        return hash != null && BCrypt.checkpw(rawPassword, hash);
    }

    public Optional<UserDocument> getUser(String username) {
        return userRepository.findByUsername(username);
    }

    public List<UserDocument> getAllUsers() {
        return userRepository.findAll();
    }

    /**
     * Get all users with pagination and optional search query.
     * 
     * @param query Optional search query for username
     * @param pageable Pagination parameters
     * @return Page of users
     */
    public Page<UserDocument> getAllUsers(String query, Pageable pageable) {
        if (query != null && !query.trim().isEmpty()) {
            return userRepository.findByUsernameContainingIgnoreCase(query, pageable);
        }
        return userRepository.findAll(pageable);
    }

    /**
     * Update user information (roles, status, etc.).
     * 
     * @param userId User ID to update
     * @param updateData Map containing fields to update
     * @return Updated user document or null if not found
     */
    public UserDocument updateUser(String userId, Map<String, Object> updateData) {
        Optional<UserDocument> userOpt = userRepository.findById(userId);
        if (userOpt.isEmpty()) {
            return null;
        }

        UserDocument user = userOpt.get();
        boolean updated = false;

        // Update role if provided
        if (updateData.containsKey("role")) {
            String newRole = (String) updateData.get("role");
            if (newRole != null && (newRole.equals("USER") || newRole.equals("ADMIN"))) {
                user.setRole(newRole);
                updated = true;
            }
        }

        // Update active status if provided
        if (updateData.containsKey("isActive")) {
            Boolean isActive = (Boolean) updateData.get("isActive");
            if (isActive != null) {
                user.setActive(isActive);
                updated = true;
            }
        }

        if (updated) {
            user.setUpdatedAt(LocalDateTime.now());
            return userRepository.save(user);
        }

        return user;
    }

    /**
     * Update user's last login timestamp.
     * 
     * @param username Username to update
     */
    public void updateLastLogin(String username) {
        Optional<UserDocument> userOpt = userRepository.findByUsername(username);
        if (userOpt.isPresent()) {
            UserDocument user = userOpt.get();
            user.setLastLoginAt(LocalDateTime.now());
            user.setUpdatedAt(LocalDateTime.now());
            userRepository.save(user);
        }
    }

    /**
     * Get dashboard statistics.
     * 
     * @return Map containing various user statistics
     */
    public Map<String, Object> getUserStats() {
        Map<String, Object> stats = new HashMap<>();
        
        long totalUsers = userRepository.count();
        long activeUsers = userRepository.countByIsActive(true);
        long adminUsers = userRepository.countByRole("ADMIN");
        long regularUsers = userRepository.countByRole("USER");
        
        // Count users who logged in today
        LocalDateTime today = LocalDateTime.now().withHour(0).withMinute(0).withSecond(0);
        long todayLogins = userRepository.countByLastLoginAtAfter(today);
        
        stats.put("totalUsers", totalUsers);
        stats.put("activeUsers", activeUsers);
        stats.put("inactiveUsers", totalUsers - activeUsers);
        stats.put("adminUsers", adminUsers);
        stats.put("regularUsers", regularUsers);
        stats.put("todayLogins", todayLogins);
        
        return stats;
    }
}

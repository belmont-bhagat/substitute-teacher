package edu.belmont.pranish.model;

import lombok.Data;

/**
 * Model class representing a login request.
 * Uses Lombok's @Data annotation to automatically generate:
 * - Getters and setters for all fields
 * - toString() method
 * - equals() and hashCode() methods
 * - A required args constructor
 */
@Data
public class LoginRequest {
    
    /**
     * Username provided by the user during login
     */
    private String username;
    
    /**
     * Password provided by the user during login
     */
    private String password;
    
}



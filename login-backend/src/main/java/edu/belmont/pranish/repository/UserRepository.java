package edu.belmont.demo.repository;

import edu.belmont.demo.model.UserDocument;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.time.LocalDateTime;
import java.util.Optional;

public interface UserRepository extends MongoRepository<UserDocument, String> {
    Optional<UserDocument> findByUsername(String username);
    
    // Search methods
    Page<UserDocument> findByUsernameContainingIgnoreCase(String username, Pageable pageable);
    
    // Count methods for statistics
    long countByIsActive(boolean isActive);
    long countByRole(String role);
    long countByLastLoginAtAfter(LocalDateTime dateTime);
}

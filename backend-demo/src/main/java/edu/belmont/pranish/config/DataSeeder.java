package edu.belmont.demo.config;

import edu.belmont.demo.model.UserDocument;
import edu.belmont.demo.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCrypt;

import java.time.LocalDateTime;

@Configuration
public class DataSeeder {

    @Bean
    CommandLineRunner seedUsers(UserRepository userRepository) {
        return args -> {
            // Seed admin user
            userRepository.findByUsername("admin").orElseGet(() -> {
                UserDocument admin = new UserDocument("admin", BCrypt.hashpw("password", BCrypt.gensalt()), "ADMIN");
                admin.setActive(true);
                admin.setLastLoginAt(LocalDateTime.now().minusDays(1));
                return userRepository.save(admin);
            });

            // Seed regular user
            userRepository.findByUsername("user").orElseGet(() -> {
                UserDocument user = new UserDocument("user", BCrypt.hashpw("password", BCrypt.gensalt()), "USER");
                user.setActive(true);
                user.setLastLoginAt(LocalDateTime.now().minusHours(2));
                return userRepository.save(user);
            });

            // Seed additional test users
            for (int i = 1; i <= 5; i++) {
                final String username = "testuser" + i;
                final int userIndex = i; // Make i effectively final
                userRepository.findByUsername(username).orElseGet(() -> {
                    UserDocument testUser = new UserDocument(username, BCrypt.hashpw("password", BCrypt.gensalt()), "USER");
                    testUser.setActive(userIndex <= 3); // First 3 users active, others inactive
                    testUser.setLastLoginAt(LocalDateTime.now().minusDays(userIndex));
                    return userRepository.save(testUser);
                });
            }

            // Seed one more admin for testing
            userRepository.findByUsername("admin2").orElseGet(() -> {
                UserDocument admin2 = new UserDocument("admin2", BCrypt.hashpw("password", BCrypt.gensalt()), "ADMIN");
                admin2.setActive(true);
                admin2.setLastLoginAt(LocalDateTime.now().minusHours(5));
                return userRepository.save(admin2);
            });
        };
    }
}

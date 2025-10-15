package com.example.simpleloginbackend.config;

import com.example.simpleloginbackend.model.UserDocument;
import com.example.simpleloginbackend.repository.UserRepository;
import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCrypt;

@Configuration
public class DataSeeder {

    @Bean
    CommandLineRunner seedAdmin(UserRepository userRepository) {
        return args -> {
            userRepository.findByUsername("admin").orElseGet(() -> {
                UserDocument admin = new UserDocument();
                admin.setUsername("admin");
                admin.setPasswordHash(BCrypt.hashpw("password", BCrypt.gensalt()));
                return userRepository.save(admin);
            });
        };
    }
}

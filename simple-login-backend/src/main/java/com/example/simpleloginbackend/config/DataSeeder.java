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
                admin.setRole("instructor");
                return userRepository.save(admin);
            });

            // Seed students student1..student10 with role=student, password=password
            for (int i = 1; i <= 10; i++) {
                final String uname = "student" + i;
                userRepository.findByUsername(uname).orElseGet(() -> {
                    UserDocument student = new UserDocument();
                    student.setUsername(uname);
                    student.setPasswordHash(BCrypt.hashpw("password", BCrypt.gensalt()));
                    student.setRole("student");
                    return userRepository.save(student);
                });
            }
        };
    }
}

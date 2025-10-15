package com.example.simpleloginbackend.service;

import com.example.simpleloginbackend.model.UserDocument;
import com.example.simpleloginbackend.repository.UserRepository;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AuthService {

    private final UserRepository userRepository;

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
}

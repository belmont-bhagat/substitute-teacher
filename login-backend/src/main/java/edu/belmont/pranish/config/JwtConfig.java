package edu.belmont.demo.config;

import edu.belmont.demo.service.JwtService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class JwtConfig {

    @Bean
    public JwtService jwtService(
            @Value("${auth.jwt.secret:change-me-change-me-change-me-change-me}") String secret,
            @Value("${auth.jwt.ttlSeconds:3600}") long ttlSeconds
    ) {
        return new JwtService(secret, ttlSeconds);
    }
}

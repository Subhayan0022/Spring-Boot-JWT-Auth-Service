package com.subhayan.authservice.controller;

import com.subhayan.authservice.dto.DtoAuthLogin.*;
import com.subhayan.authservice.exception.InvalidCredentialsException;
import com.subhayan.authservice.security.CustomUserDetailsService;
import com.subhayan.authservice.security.JwtUtil;
import com.subhayan.authservice.security.RefreshTokenService;
import io.swagger.v3.oas.annotations.security.SecurityRequirement;
import jakarta.validation.Valid;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/auth")
public class AuthTokenController {

    private final RefreshTokenService refreshTokenService;
    private final JwtUtil jwtUtil;
    private final CustomUserDetailsService customUserDetailsService;

    public AuthTokenController(RefreshTokenService refreshTokenService, JwtUtil jwtUtil,
                               CustomUserDetailsService customUserDetailsService) {
        this.refreshTokenService = refreshTokenService;
        this.jwtUtil = jwtUtil;
        this.customUserDetailsService = customUserDetailsService;
    }

    @PostMapping("/refresh")
    public ResponseEntity<AuthResponse> refresh(@Valid @RequestBody RefreshRequest refreshRequest) {
        String userId = refreshTokenService.getRefreshToken(refreshRequest.refreshToken());

        if (userId == null) {
            throw new InvalidCredentialsException("Invalid or expired refresh token");
        }

        customUserDetailsService.loadUserById(userId);

        String newAccessToken = jwtUtil.generateToken(userId);
        String newRefreshToken = refreshTokenService.generateRefreshToken(userId);
        refreshTokenService.deleteRefreshToken(refreshRequest.refreshToken());

        return ResponseEntity.ok(new AuthResponse(newAccessToken, newRefreshToken));
    }

    @PostMapping("/logout")
    @SecurityRequirement(name = "Bearer Token")
    public ResponseEntity<Void> logout(@Valid @RequestBody RefreshRequest refreshRequest) {
        refreshTokenService.deleteRefreshToken(refreshRequest.refreshToken());
        return ResponseEntity.noContent().build();
    }
}

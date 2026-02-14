package com.subhayan.authservice.security;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import javax.crypto.SecretKey;
import java.util.Base64;
import java.util.Date;

@Component
public class JwtUtil {
    private final SecretKey secretKey;
    private final long expiration;

    public JwtUtil(@Value("${jwt.secret}") String secret, @Value("${jwt.expiration}") long expiration) {
        this.secretKey = Keys.hmacShaKeyFor(Base64.getDecoder().decode(secret));
        this.expiration = expiration;
    }

    public String generateToken(String email) {
        return Jwts.builder()
                .subject(email).issuedAt(new Date()).expiration(new Date(System.currentTimeMillis() + expiration)).signWith(secretKey).compact();
    }

    public Claims parseToken(String token) {
        return Jwts.parser().verifyWith(secretKey).build().parseSignedClaims(token).getPayload();
    }

    public String getEmailFromToken(String token) {
        return parseToken(token).getSubject();
    }

    public boolean validateToken(String token,  String email) {
        return getEmailFromToken(token).equals(email) && !checkExpiration(token);

    }

    public boolean checkExpiration(String token) {
        return parseToken(token).getExpiration().before(new Date());
    }
}

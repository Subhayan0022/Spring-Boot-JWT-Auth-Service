package com.subhayan.authservice.dto;

import com.subhayan.authservice.entity.Role;
import com.subhayan.authservice.entity.Salutation;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

public record UserDetailsResponse(
        UUID id,
        Salutation salutation,
        String firstname,
        String lastname,
        String email,
        String phoneNumber,
        LocalDate dateOfBirth,
        Role role,
        LocalDateTime createdAt
) {}

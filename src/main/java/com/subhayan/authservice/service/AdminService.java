package com.subhayan.authservice.service;

import com.subhayan.authservice.dto.UserDetailsResponse;
import com.subhayan.authservice.entity.UserEntity;
import com.subhayan.authservice.repository.UserRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Slf4j
@Service
public class AdminService {
    private final UserRepository userRepository;

    public AdminService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }

    public UserDetailsResponse getUserDetailsById(UUID userId) {
        UserEntity user = userRepository.findById(userId)
                .orElseThrow(() -> {
                    log.warn("User with id {} not found", userId);
                    return new RuntimeException("User with id " + userId + " not found");
                });

        log.info("ADMIN : User with id {} found", userId);
        return mapToUserDetailsResponse(user);
    }

    private UserDetailsResponse mapToUserDetailsResponse(UserEntity user){
        return  new UserDetailsResponse(
                user.getId(),
                user.getSalutation(),
                user.getFirstName(),
                user.getLastName(),
                user.getEmail(),
                user.getPhoneNumber(),
                user.getDateOfBirth(),
                user.getRole(),
                user.getCreatedAt()
        );
    }


}

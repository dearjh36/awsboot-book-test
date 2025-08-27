package org.awsboot.config.auth.dto;

import lombok.Builder;
import lombok.Getter;
import org.awsboot.domain.user.Role;
import org.awsboot.domain.user.User;

import java.util.Map;

@Getter
public class GoogleUser {
    private String name;
    private String email;
    private String picture;

    @Builder
    public GoogleUser(String name, String email, String picture) {
        this.name = name;
        this.email = email;
        this.picture = picture;
    }

    public static GoogleUser of(Map<String, Object> attributes){
        return GoogleUser.builder()
                .name((String) attributes.get("name"))
                .email((String) attributes.get("email"))
                .picture((String) attributes.get("picture"))
                .build();
    }

    public User toEntity() {
        return User.builder()
                .name(name)
                .email(email)
                .picture(picture)
                .role(Role.GUEST)
                .build();
    }
}

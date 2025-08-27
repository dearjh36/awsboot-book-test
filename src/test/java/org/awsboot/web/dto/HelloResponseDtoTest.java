package org.awsboot.web.dto;

import org.junit.Test;

import static org.assertj.core.api.Assertions.assertThat;
import static org.junit.Assert.*;

public class HelloResponseDtoTest {

    @Test
    public void 룸복_기능_테스트(){
        // Given
        String name = "test";
        int amount = 1000;

        // When
        HelloResponseDto dto = new HelloResponseDto(name, amount);

        // Then
        // assertThat : CoreMatchers와 달리 추가적으로 라이브러리 필요 X, 좀 더 확시한 자동완성 지원
        assertThat(dto.getName()).isEqualTo(name);
        assertThat(dto.getAmount()).isEqualTo(amount);

    }

}
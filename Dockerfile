# Multi-stage build를 사용하여 이미지 크기 최적화
FROM gradle:7.4.2-jdk8 AS builder

# 작업 디렉토리 설정
WORKDIR /app

# 의존성 파일들 먼저 복사 (캐시 최적화)
COPY build.gradle settings.gradle gradlew ./
COPY gradle ./gradle

# 의존성 다운로드 (캐시 활용)
RUN gradle dependencies --no-daemon

# 소스 코드 복사 및 빌드
COPY . .
RUN gradle clean build --no-daemon -x test

# 실행 환경
FROM openjdk:8-jre-slim

WORKDIR /app

# 빌드된 JAR 파일 복사
COPY --from=builder /app/build/libs/*.jar app.jar

# 8080 포트 노출
EXPOSE 8080

# 애플리케이션 실행
ENTRYPOINT ["java", "-jar", "app.jar"]
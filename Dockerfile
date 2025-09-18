# --- Build stage ---
FROM eclipse-temurin:8-jdk AS build
WORKDIR /app

# Wrapper/설정 먼저 복사 (캐시 최적화)
COPY gradlew ./
COPY gradle ./gradle
COPY build.gradle ./
# settings.gradle 파일이 있으면 아래 줄을 살리고, 없으면 지워도 됩니다.
# COPY settings.gradle ./

# gradlew 권한 + 의존성 다운로드(로그 자세히)
RUN chmod +x ./gradlew
RUN ./gradlew --no-daemon --stacktrace --info dependencies

# 소스 복사 후 빌드
COPY . .
RUN ./gradlew clean build --no-daemon -x test

# --- Runtime stage ---
FROM eclipse-temurin:8-jre
WORKDIR /app

# 실행 가능한 jar만 복사(plain 제외). 필요하면 패턴을 네 결과에 맞게 바꾸세요.
COPY --from=build /app/build/libs/*-SNAPSHOT.jar /app/app.jar
# 예: *-boot.jar 또는 프로젝트명-1.0.0.jar 처럼 바꿔도 됩니다.

EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]

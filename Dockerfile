# --- Build stage ---
<<<<<<< HEAD
FROM gradle:6.9.4-jdk8 AS build
=======
FROM gradle:7.4.2-jdk8 AS build
>>>>>>> origin/main
WORKDIR /app

# 소스 복사
COPY . .

<<<<<<< HEAD
# gradle 직접 사용 (Spring Boot 2.4.1과 호환되는 버전)
=======
# gradle 직접 사용 (wrapper 사용 안함)
>>>>>>> origin/main
RUN gradle clean build -x test --no-daemon

# --- Runtime stage ---
FROM eclipse-temurin:8-jre
WORKDIR /app

# 실행 가능한 jar만 복사
COPY --from=build /app/build/libs/*-SNAPSHOT-*.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
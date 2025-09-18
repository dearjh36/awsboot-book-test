# --- Build stage ---
FROM gradle:7.4.2-jdk8 AS build
WORKDIR /app

# 소스 복사
COPY . .

# gradle 직접 사용 (wrapper 사용 안함)
RUN gradle clean build -x test --no-daemon

# --- Runtime stage ---
FROM eclipse-temurin:8-jre
WORKDIR /app

# 실행 가능한 jar만 복사
COPY --from=build /app/build/libs/*-SNAPSHOT-*.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
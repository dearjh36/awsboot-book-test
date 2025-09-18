# --- Build stage ---
FROM eclipse-temurin:8-jdk AS build
WORKDIR /app

# 모든 파일을 먼저 복사
COPY . .

# gradlew 권한 설정 (더 확실하게)
RUN chmod 755 ./gradlew
RUN ls -la ./gradlew

# 의존성 다운로드 및 빌드
RUN ./gradlew --no-daemon --stacktrace --info dependencies
RUN ./gradlew clean build --no-daemon -x test

# --- Runtime stage ---
FROM eclipse-temurin:8-jre
WORKDIR /app

# 실행 가능한 jar만 복사
COPY --from=build /app/build/libs/*-SNAPSHOT-*.jar /app/app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/app.jar"]
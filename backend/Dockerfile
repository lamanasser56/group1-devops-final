# Use Eclipse Temurin 21 JDK Alpine
FROM eclipse-temurin:21-jdk-alpine

# Set working directory
WORKDIR /app

# Copy the built JAR
COPY target/burger-builder-backend-1.0.0.jar backend-app.jar

# Expose port
EXPOSE 8080

# Run the JAR
ENTRYPOINT ["java", "-jar", "backend-app.jar"]

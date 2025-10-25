# Backend Issue Resolution

## Problem
The backend was not working due to Java version compatibility issues and database connection problems.

## Issues Found and Fixed

### 1. Java Version Compatibility
- **Problem**: The system had Java 24 installed, but the project was configured for Java 21
- **Error**: `java.lang.ExceptionInInitializerError: com.sun.tools.javac.code.TypeTag :: UNKNOWN`
- **Solution**: 
  - Updated `pom.xml` to use Java 21 (more stable with Spring Boot 3.2.0)
  - Set `JAVA_HOME` to use Java 21: `/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home`

### 2. Database Connection
- **Problem**: Backend couldn't connect to PostgreSQL database
- **Error**: `org.postgresql.util.PSQLException: The connection attempt failed`
- **Solution**:
  - Started PostgreSQL using Docker: `docker run --name burgerbuilder-postgres -e POSTGRES_DB=burgerbuilder -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=YourStrong!Passw0rd -p 5432:5432 -d postgres:15`
  - Used explicit database configuration parameters when starting the backend

## How to Start the Backend

### Option 1: Using the startup script (Recommended)
```bash
cd backend
./start-backend.sh
```

### Option 2: Manual startup
```bash
# Set Java 21
export JAVA_HOME=/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home

# Start PostgreSQL (if not already running)
docker run --name burgerbuilder-postgres -e POSTGRES_DB=burgerbuilder -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=YourStrong!Passw0rd -p 5432:5432 -d postgres:15

# Start the backend
cd backend
java -jar target/burger-builder-backend-1.0.0.jar \
    --spring.profiles.active=docker \
    --spring.datasource.url=jdbc:postgresql://localhost:5432/burgerbuilder \
    --spring.datasource.username=postgres \
    --spring.datasource.password=YourStrong!Passw0rd
```

## Verification
- Backend health check: `curl http://localhost:8080/actuator/health`
- Ingredients API: `curl http://localhost:8080/api/ingredients`
- Backend should return `{"status":"UP"}` for health check
- Ingredients API should return a JSON array of burger ingredients

## Current Status
✅ Backend compiles successfully  
✅ Backend starts without errors  
✅ Database connection established  
✅ API endpoints responding  
✅ Health check endpoint working  
✅ Ingredients API working  

The backend is now fully functional and ready for use!

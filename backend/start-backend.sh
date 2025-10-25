#!/bin/bash

# Burger Builder Backend Startup Script
# This script starts the backend with the correct Java version and database configuration

echo "Starting Burger Builder Backend..."

# Set Java 21 as the JAVA_HOME
export JAVA_HOME=/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home

# Navigate to backend directory
cd "$(dirname "$0")"

# Check if PostgreSQL is running
if ! docker ps | grep -q burgerbuilder-postgres; then
    echo "Starting PostgreSQL database..."
    docker run --name burgerbuilder-postgres -e POSTGRES_DB=burgerbuilder -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=YourStrong!Passw0rd -p 5432:5432 -d postgres:15
    echo "Waiting for PostgreSQL to start..."
    sleep 10
fi

# Start the backend with explicit database configuration
echo "Starting backend application..."
java -jar target/burger-builder-backend-1.0.0.jar \
    --spring.profiles.active=docker \
    --spring.datasource.url=jdbc:postgresql://localhost:5432/burgerbuilder \
    --spring.datasource.username=postgres \
    --spring.datasource.password=YourStrong!Passw0rd

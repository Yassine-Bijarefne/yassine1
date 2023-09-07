# Use the official Maven image as the build environment
FROM maven:3.8.4-openjdk-11 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy only the POM file to take advantage of Docker layer caching
COPY pom.xml .

# Download dependencies and build the project
RUN mvn dependency:go-offline
RUN mvn package -DskipTests

# Second stage: Use a minimal JRE-based image for the runtime environment
FROM adoptopenjdk:11-jre-hotspot

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the build stage to the runtime stage
COPY --from=build /app/target/springboot-1.0.0.jar .

# Expose the port that your Spring Boot application listens on
EXPOSE 9090

# Define the command to run the Spring Boot application
CMD ["java", "-jar", "springboot-1.0.0.jar"]




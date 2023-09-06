# Use a Maven image as the build environment
FROM maven:3.8 AS build
# Set the working directory in the container
WORKDIR /app
# Copy the Maven project files (pom.xml) to the container
COPY pom.xml .
# Download the project dependencies (this step is cached if pom.xml hasn't changed)
RUN mvn dependency:go-offline
# Copy the application source code to the container
COPY src/ src/
# Build the Spring Boot application
RUN mvn package

# Create a runtime image with OpenJDK
FROM openjdk:11.0-jre-slim
# Set the working directory in the container
WORKDIR /app
# Copy the built JAR file from the build stage to the runtime image
COPY --from=build /app/target/springboot-1.0.0.jar .
# Expose the port that the Spring Boot application will listen on (adjust the port as needed)
EXPOSE 8080
# Define the command to run the Spring Boot application
CMD ["java", "-jar", "springboot-1.0.0.jar"]

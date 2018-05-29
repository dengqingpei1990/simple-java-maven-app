FROM openjdk:7-jdk-alpine
COPY target/my-app-*.jar /my-app.jar
CMD ["java","-jar","/my-app.jar"]

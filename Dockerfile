FROM openjdk:8-jdk-alpine
EXPOSE 9090
COPY target/*.jar welcome.jar
ENTRYPOINT ["java","-jar","/welcome.jar"]
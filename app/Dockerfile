FROM openjdk:latest

#To add the runnable jar file of the backend project to the container
ADD ./target/school-backend-docker.jar school-backend-docker.jar

#To specify the command that runs the jar files in the /bin/bash in the container
ENTRYPOINT ["java" ,"-jar", "/school-backend-docker.jar"]
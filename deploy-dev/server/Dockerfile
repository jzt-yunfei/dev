FROM openjdk:8
WORKDIR /app-home
ADD ./douya-server-boot/target/douya-server-boot-0.0.1-SNAPSHOT.jar /app-home/app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app-home/app.jar"]

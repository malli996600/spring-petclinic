FROM maven:3-jdk-11 As builder
LABEL author=Mallikarjun
RUN git clone https://github.com/spring-projects/spring-petclinic.git && cd spring-petclinic && mvn clean package

FROM openjdk:11.0-jdk
COPY --from=builder spring-petclinic/target/spring-petclinic-2.7.0-SNAPSHOT.jar /spring/spring-petclinic.jar
WORKDIR spring
EXPOSE 8080
CMD ["java","-jar","spring-petclinic.jar"]  
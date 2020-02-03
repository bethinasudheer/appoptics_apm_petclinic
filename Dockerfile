FROM maven:3.3.9-jdk-8-alpine AS build
WORKDIR /usr/src/app
ADD . /usr/src/app/
RUN apk add --no-cache procps &&  mvn  clean package -DskipTests
FROM openjdk:8-jre-alpine
WORKDIR /usr/src/app/
COPY --from=build /usr/src/app/target/spring-petclinic-2.2.0.BUILD-SNAPSHOT.jar /usr/app/spring-petclinic-2.2.0.BUILD-SNAPSHOT.jar
ADD ./appoptics-java.sh /usr/src/app/appoptics-java.sh
RUN /bin/sh /usr/src/app/appoptics-java.sh --service-key=infRjISEHKBCwehplKWnUZ1-_iBPCrxToLks2oNywRn56-9zUNVF2luDZv06UyMcnDGikrU:sample
ENTRYPOINT java -javaagent:/usr/src/app/appoptics-agent.jar -jar /usr/app/spring-petclinic-2.2.0.BUILD-SNAPSHOT.jar

FROM maven:3.8.3-openjdk-17-slim as build-step
WORKDIR /app
COPY src ./src
COPY pom.xml ./pom.xml
RUN mvn install -DskipTests=true

FROM openjdk:17-alpine
RUN mkdir config
COPY --from=build-step /app/target/fractionable-api.jar fractionable-api.jar
RUN apk update && apk add bash
EXPOSE 80
ENTRYPOINT ["java", "-jar", "fractionable-api.jar"]

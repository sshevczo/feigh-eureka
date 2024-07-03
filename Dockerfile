FROM openjdk:17-jdk-slim  AS build  
WORKDIR /app
COPY . .
RUN ./mvnw package

FROM openjdk:17-jdk-slim AS server
WORKDIR /app
COPY --from=build /app/server/target/*.jar app.jar
EXPOSE 7111
ENTRYPOINT [ "java", "-jar", "app.jar" ]

FROM openjdk:17-jdk-slim AS client
WORKDIR /app
COPY --from=build /app/client/target/*.jar app.jar
EXPOSE 7211
ENTRYPOINT [ "java", "-jar", "app.jar" ]
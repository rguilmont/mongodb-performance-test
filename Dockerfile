FROM eclipse-temurin:11-jre-alpine

COPY ./latest-version/mongodb-performance-test.jar /app/mongodb-performance-test.jar

ENTRYPOINT ["sh", "-c"]

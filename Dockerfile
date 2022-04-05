FROM ubuntu as builder

WORKDIR /swagger-petstore

RUN apt update -y && DEBIAN_FRONTEND=noninteractive apt install git maven -y
RUN git clone https://github.com/xansec/swagger-petstore.git .
RUN mvn package
 
FROM openjdk:8-jre-alpine
COPY --from=builder /swagger-petstore/target/lib/jetty-runner.jar /jetty-runner.jar
COPY --from=builder /swagger-petstore/target/*.war /server.war
COPY --from=builder /swagger-petstore/src/main/resources/openapi.yaml /openapi.yaml
COPY --from=builder /swagger-petstore/inflector.yaml /inflector.yaml

EXPOSE 8080

CMD ["java", "-jar", "-DswaggerUrl=openapi.yaml", "/jetty-runner.jar", "--log", "/var/log/yyyy_mm_dd-requests.log", "/server.war"]

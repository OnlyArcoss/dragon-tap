FROM eclipse-temurin:25-jdk-jammy AS build

WORKDIR /build

RUN apt-get update && \
    apt-get install -y --no-install-recommends maven && \
    rm -rf /var/lib/apt/lists/*

COPY pom.xml ./

# Resolve dependencies before copying source to improve Docker layer cache reuse.
RUN mvn dependency:go-offline -DskipTests

COPY src ./src
RUN mvn package -DskipTests && \
    JAR_FILE=$(find target -maxdepth 1 -type f -name '*.jar' ! -name '*-sources.jar' ! -name '*-javadoc.jar' | head -n 1) && \
    cp "$JAR_FILE" target/app.jar

FROM eclipse-temurin:25-jdk-jammy AS final

ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser

WORKDIR /app
COPY --from=build /build/target/app.jar /app/app.jar

USER appuser

EXPOSE 4181

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
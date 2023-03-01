FROM openjdk:11-jdk-slim
COPY . /app
RUN apt-get update && \
    apt-get -y install --no-install-recommends default-jdk && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
CMD ["java", "-jar", "/app/target/app.jar"]
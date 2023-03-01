FROM openjdk:11-jdk-slim

WORKDIR /app

# 필요한 파일만 복사
COPY --chown=daemon:daemon target/app.jar app.jar

# 필요한 패키지만 설치
RUN apt-get update && \
    apt-get -y install --no-install-recommends openssh-client vim && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 명령어 실행
CMD ["java", "-jar", "app.jar"]
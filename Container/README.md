기존 Dockerfile에서는 매번 **`apt-get update`**를 수행하여 패키지 관리자의 패키지 목록을 최신으로 업데이트하고, **`default-jdk`**, **`ssh`**, **`vim`** 패키지를 설치한 후 **`java`** 명령어로 jar 파일을 실행하도록 설정하였습니다.

1. 베이스 이미지 변경

**`FROM debian`**을 **`FROM openjdk:11-jdk-slim`**으로 변경하였습니다. 최신 버전의 openjdk 이미지는 debian을 기반으로 하여 기본적인 JDK 패키지를 제공하므로, debian 이미지 대신 OpenJDK slim 이미지를 사용하면 이미지 크기를 줄일 수 있습니다.

2. 작업 디렉터리 추가

**`WORKDIR /app`**을 추가하였습니다. 이는 작업 디렉토리를 **`/app`**으로 설정하고 작업 디렉토리에서 명령을 실행하도록 지시합니다.

3. 필요한 파일만 복사

**`COPY . /app`**을 **`COPY --chown=daemon:daemon target/app.jar app.jar`**로 변경하였습니다. **`-chown=daemon:daemon`** 옵션은 사용자와 그룹을 지정하여 보안을 강화합니다. **`target/app.jar`** 파일만 복사하여 필요한 파일만 복사하도록 변경하였습니다.

4. RUN문 병합 / 불필요한 패키지 설치하지 않기 / 캐시 삭제

**`RUN apt-get update && \ apt-get -y install default-jdk ssh vim`**을 **`RUN apt-get update && \ apt-get -y install --no-install-recommends openssh-client vim && \ apt-get clean && \ rm -rf /var/lib/apt/lists/*`**로 변경하였습니다. 이 변경 사항은 apt-get 명령을 하나의 RUN 문으로 병합하여 이미지 캐시 레이어를 최적화합니다. 또한 **`-no-install-recommends`** 옵션을 추가하여 불필요한 패키지를 설치하지 않습니다. **`apt-get clean`**과 **`rm -rf /var/lib/apt/lists/*`**를 추가하여 apt 캐시를 삭제하여 이미지 크기를 줄입니다.

5. 경로 변경

**`CMD ["java", "-jar", "/app/target/app.jar"]`**는 **`CMD ["java", "-jar", "app.jar"]`**으로 변경되었습니다. 이는 **`WORKDIR /app`**에서 작업 디렉토리를 설정하였기 때문에, **`/app/target/app.jar`** 경로 대신 **`app.jar`** 경로를 사용하여 명령을 실행합니다.
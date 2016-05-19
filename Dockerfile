FROM jenkins

USER root
RUN apt-get -y update && apt-get -y install \
    docker.io \
    make

# Install Docker Compose
ENV DOCKER_COMPOSE_VERSION 1.7.1

RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

RUN chmod +x /usr/local/bin/docker-compose

ENV JAVA_OPTS -Dhudson.model.DirectoryBrowserSupport.CSP=\"sandbox allow-scripts; default-src \'self\' \'unsafe-inline\' data:;\"

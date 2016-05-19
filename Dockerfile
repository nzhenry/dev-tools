FROM jenkins

USER root

# Install prerequisites

RUN apt-get update && apt-get -y install \
    apt-transport-https \
    ca-certificates \
    make

# Install Docker

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

RUN echo deb https://apt.dockerproject.org/repo debian-jessie main > /etc/apt/sources.list.d/docker.list

RUN apt-get update && apt-get -y install docker-engine

# Install Docker Compose

ENV DOCKER_COMPOSE_VERSION 1.7.1

RUN curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

RUN chmod +x /usr/local/bin/docker-compose

# Set Jenkins content security policy

ENV JAVA_OPTS -Dhudson.model.DirectoryBrowserSupport.CSP=\"sandbox allow-scripts; default-src \'self\' \'unsafe-inline\' data:;\"

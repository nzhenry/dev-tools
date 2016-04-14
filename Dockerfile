FROM killercentury/jenkins-dind

RUN apt-get update && apt-get install -y make

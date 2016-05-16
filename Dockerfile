FROM killercentury/jenkins-dind

RUN apt-get update && apt-get install -y make

RUN cat supervisord.conf > temp
RUN sed s/'command=java -jar'/'command=java -jar -Dhudson.model.DirectoryBrowserSupport.CSP="sandbox allow-scripts; default-src 'self' 'unsafe-inline' data:;"'/ temp > supervisord.conf
RUN rm temp

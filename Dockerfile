FROM killercentury/jenkins-dind

RUN apt-get update && apt-get install -y make

RUN cat /etc/supervisor/conf.d/supervisord.conf > /etc/supervisor/conf.d/temp
RUN sed s/"command=java -jar"/"command=java -jar -Dhudson.model.DirectoryBrowserSupport.CSP=\"sandbox allow-scripts; default-src \'self\' \'unsafe-inline\' data:;\""/ /etc/supervisor/conf.d/temp > /etc/supervisor/conf.d/supervisord.conf
RUN rm /etc/supervisor/conf.d/temp

####################################################
# Don't run this script manually!                  #
# The parent script setup.sh will do that for you. #
####################################################

# make sure the package manager is up to date
apt-get update &&

# add entropy. this is needed for cloud instances
apt-get install -y haveged &&

# create directory for ssl certs
mkdir /root/certs &&

# create ssl certs
openssl req -subj '/CN=jenkins.livehen.com/O=Henry Johnson/C=CA' \
	-new -newkey rsa:2048 -days 365 -nodes -x509 \
	-keyout /root/certs/jenkins.livehen.com.key \
	-out /root/certs/jenkins.livehen.com.crt &&

# install ssl proxy
docker run -d -p 80:80 -p 443:443 -v /root/certs:/etc/nginx/certs -v /var/run/docker.sock:/tmp/docker.sock:ro jwilder/nginx-proxy &&

# install jenkins
docker run -d -e VIRTUAL_HOST=jenkins.livehen.com -e VIRTUAL_PORT=8080 -v jenkins_home:/var/jenkins_home jenkins

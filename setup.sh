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

openssl req -subj '/CN=jira.livehen.com/O=Henry Johnson/C=CA' \
	-new -newkey rsa:2048 -days 365 -nodes -x509 \
	-keyout /root/certs/jira.livehen.com.key \
	-out /root/certs/jira.livehen.com.crt &&

# install jenkins with docker
docker build -t jenkins-img .
docker-compose up -d

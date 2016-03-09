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
openssl req -subj '/CN=hjohnsondev.com/O=Henry Johnson/C=CA' \
	-new -newkey rsa:2048 -days 365 -nodes -x509 \
	-keyout /root/certs/hjohnsondev.com.key \
	-out /root/certs/hjohnsondev.com.crt &&

# download docker-compose
curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` \
	> /usr/local/bin/docker-compose &&

# make it executable
chmod +x /usr/local/bin/docker-compose
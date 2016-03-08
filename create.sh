# set digital ocean API key
API_KEY=$1

if [ "${API_KEY}" == "" ]; then
	echo ERROR: API key not provided! Please provide the API key
	exit 1
fi

echo hello

# list digital ocean regions
#curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer ${API_KEY}" "https://api.digitalocean.com/v2/regions" | python -m json.tool

# list digital ocean sizes
#curl -X GET -H "Content-Type: application/json" -H "Authorization: Bearer ${API_KEY}" "https://api.digitalocean.com/v2/sizes" | python -m json.tool

# create digital ocean droplet
#docker-machine create --driver digitalocean --digitalocean-access-token ${API_KEY} --digitalocean-region tor1 --digitalocean-size 512mb jenkins-host

# create jenkins app
docker-machine ssh jenkins-host "apt-get update && \
	apt-get install haveged && \
	apt-get install docker-compose && \
	mkdir /root/certs && \
	openssl req -subj '/CN=hjohnsondev.com/O=Henry Johnson/C=CA' \
		-new -newkey rsa:2048 -days 365 -nodes -x509 \
		-keyout /root/certs/hjohnsondev.com.key \
		-out /root/certs/hjohnsondev.com.crt && \
	git clone https://github.com/nzhenry/docker-jenkins.git && \
	cd /root/docker-jenkins && \
	docker-compose up"
	
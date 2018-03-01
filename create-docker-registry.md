# Tested on Ubuntu 16.04.4
# Three servers, registry, build and deploy

- On all the 3 servers, deploy docker using the script, [Github page](https://github.com/urao/kubernetes-act/blob/master/install_docker.sh)
- On Registry server
    1. Install docker-compose, [Docker page](https://docs.docker.com/compose/install/)
    2. Create folder certs . (mkdir -p certs)
    3. Create docker-compose.yaml [file](https://github.com/urao/kubernetes-act/blob/master/docker-compose.yml)
    4. Create certificates, using command, 
       ``` openssl req -newkey rsa:4096 -nodes -sha256 -keyout certs/ca.key -x509 -days 365 -out certs/ca.crt ```
    5. Run ``` docker-compose up -d ```
    6. Verify the command return null ``` curl --insecure https://registry.com:5000/v2/ ```

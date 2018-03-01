# Tested on Ubuntu 16.04.4
## Requires 3 servers/VM's used for registry, build and deploy

- On all the 3 servers, deploy docker using the script, [Github page](https://github.com/urao/kubernetes-act/blob/master/install_docker.sh)

- On Registry server
    1. Install docker-compose, [Docker page](https://docs.docker.com/compose/install/)
    2. Create folder certs . (mkdir -p certs)
    3. Create docker-compose.yaml [file](https://github.com/urao/kubernetes-act/blob/master/docker-compose.yml)
    4. Create certificates, using command, 
       ``` openssl req -newkey rsa:4096 -nodes -sha256 -keyout certs/ca.key -x509 -days 365 -out certs/ca.crt ```
    5. Copy [file](https://github.com/urao/kubernetes-act/blob/master/registry-daemon.json) to /etc/docker/daemon.json
    6. Restart docker service, ``` systemctl restart docker.service ```
    7. Run ``` docker-compose up -d ```
    8. Verify the command return null ``` curl --insecure https://registry.com:5000/v2/ ```

- On Build server
    1. Create folder, ``` mkdir -p /etc/docker/certs.d/registry.com:5000/ ```
    2. Copy certs from Registry server to the above folder
    3. Copy [file](https://github.com/urao/kubernetes-act/blob/master/build-deploy-daemon.json) to /etc/docker/daemon.json
    4. Restart docker service, ``` systemctl restart docker.service ```
    5. You can start building docker images and push them onto Registry
    6. Verify the image is pushed using, ``` curl --insecure https://registry:5000/v2/_catalog ```
    
- On Deploy server
    1. Copy [file](https://github.com/urao/kubernetes-act/blob/master/build-deploy-daemon.json) to /etc/docker/daemon.json
    2. Restart docker service, ``` systemctl restart docker.service ```
    3. Pull docker images and run them
    


### Steps to bring up docker host1
1. Install docker on VM/Server using the [script](https://github.com/urao/docker-k8s-project/blob/master/install_docker.sh)
2. Copy the [sampe_docker_daemon](https://github.com/urao/docker-k8s-project/blob/master/multi_host_docker_etcd_portainer/docker2_vm/sample_docker_daemon) file under /etc/docker/ and re-name it as daemon.json
3. Restart docker service 
   ```
    sudo systemctl restart docker
    ```

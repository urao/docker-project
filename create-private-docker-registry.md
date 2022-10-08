### Steps to create private docker registry

1. Ensure docker service is running
```
systemctl status docker
```
2. Pull registry image
```
docker pull docker.io/registry:2
```
3. Run docker registry container, make sure port 5000 is not in use
```
docker run -d -p 5000:5000 --restart=always --name registry registry:2
```
4. Upload image on to private registry
```
docker tag hub.juniper.net/cn2/contrail-cni-init:22.1.0.93 192.168.24.10:5000/contrail-cni-init:22.1.0.93
docker push 192.168.24.10:5000/contrail-cni-init:22.1.0.93
```
5. Check the docker images
```
docker image ls
```

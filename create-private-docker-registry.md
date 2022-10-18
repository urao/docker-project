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
6. Add daemon.json under /etc/docker, with below contents and restart docker service
```
{
  "insecure-registries" : ["192.168.24.10:5000"]
}
```
```
systemctl restart docker
```

### Steps to create private docker registry with simple credentials

1. Follow step 1, 2
2. Run below commands
```
mkdir -p $HOME/auth
docker run --entrypoint htpasswd httpd:2 -Bbn <username> <password> > $HOME/auth/creds
docker run -d   -p 5000:5000   --restart=always   --name registry   -v "$(pwd)"/auth:/auth \
   -e "REGISTRY_AUTH=htpasswd"   -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
   -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/creds registry:2
```
3. Check using docker login command
```
docker login 192.168.24.10 -u <username> --password-stdin
```
4. Run above steps 4,5,6

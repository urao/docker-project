### Steps to add non-root user to docker group

```
sudo groupadd docker
sudo gpasswd -a $USER docker
logout/login 
docker run hello-world
```

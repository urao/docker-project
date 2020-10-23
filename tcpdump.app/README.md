### Dockerfile to create tcpdump container


#### Steps to create 
```
git clone https://github.com/urao/docker-project.git
cd tcpdump.app
sh build.sh
```

#### How to run the container
```
docker run --net=host --name tcpdump_app 
docker run --net=host --name tcpdump_app -i eth1 proto gre
```

### References:
[http://www.tcpdump.org/](http://www.tcpdump.org/)

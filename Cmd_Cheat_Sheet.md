## Useful commands
```
docker-compose up -d
docker-compose images
docker-compose ps
docker-compose restart
docker-compose down  <<< containers stopped and deleted
docker-compose down -v
docker search busybox
docker image ls
docker image rm <image_name>
docker image rm -f <IMAGE_ID>
docker history --no-trunc <image_id> | tac | tr -s ' ' | cut -d " " -f 5- | sed 's,^/bin/sh -c #(nop) ,,g' \
| sed 's,^/bin/sh -c,RUN,g' | sed 's, && ,\n  & ,g' | sed 's,\s*[0-9]*[\.]*[0-9]*\s*[kMG]*B\s*$,,g' | head -n -1
docker export <container_id> | gzip > <docker_name>.tgz
docker stats
docker stats <IMAGE_ID>
```

```
docker build -t netdata:1.0 .
docker build -f netdata_app/Dockerfile -t netdata .
```

```
docker save <IMAGE_ID> > <IMAGE_NAME>.tar
docker save -o <NAME>.tar <IMAGE>:<VERSION>
docker load --input image.tar
docker image tag <IMAGE_ID> <IMAGE_NAME>:<VERSION>
```

```
docker login --username=urao
docker images
docker tag <IMAGE_ID> urao/fluentd:v1.11.1
docker push urao/fluentd:v1.11.1
docker login --username=urao
docker pull urao/fluentd:v1.11.1
```

```
docker run -it -v /data:/root/data ansible bash
docker run -it -v /root/data:/data ansible ansible-playbook update_dhcpd_conf.yml -e jsonVar="@./newhost.json"
docker run --rm -v ~/.kube:/root/.kube --network=host --name=kubectl-host ukubectl:latest bash -c 'kubectl get pods'
```

### Keep docker running for debug purpose
```
CMD tail -f /dev/null
```

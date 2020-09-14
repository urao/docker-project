## Useful commands

```
docker-compose up -d
docker-compose images
docker-compose ps
docker-compose restart
docker-compose down  <<< containers stopped and deleted
docker image ls
docker image rm <image_name>
docker history --no-trunc <image_id> | tac | tr -s ' ' | cut -d " " -f 5- | sed 's,^/bin/sh -c #(nop) ,,g' \
| sed 's,^/bin/sh -c,RUN,g' | sed 's, && ,\n  & ,g' | sed 's,\s*[0-9]*[\.]*[0-9]*\s*[kMG]*B\s*$,,g' | head -n -1
docker export <container_id> | gzip > <docker_name>.tgz
```

```
docker image rm -f <IMAGE_ID>
docker load --input image.tar
docker image tag <IMAGE_ID> <IMAGE_NAME>:<VERSION>
```


### Keep docker running for debug purpose
```
CMD tail -f /dev/null
```

### Execute below commands to check docker logs on Mac

```
chmod 400 ~/Library/Containers/com.docker.docker/Data/vms/0/tty
screen $(cat ~/Library/Containers/com.docker.docker/Data/vms/0/tty)
```

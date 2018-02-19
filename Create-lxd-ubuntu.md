# Bring up lxd containers on Ubuntu (14.04 trusty)

## Steps to bring up lxd containers in privileged mode

```
apt install -t trusty-backports lxd lxd-client
lxd init
lxc launch ubuntu:16.04 helloc
Wait for couple of minutes to download the image
lxc list (List all the containers)
lxc exec helloc -- /bin/bash
Check if IP is assigned to the container, if not do, dhclient <veth-interface-name>
Login into container and try agt-get update, it tries to use IPv6 and will fail
On host, add below in /etc/sysctl.conf file and do sudo sysctl -p
   net.ipv6.conf.all.disable_ipv6 = 1
   net.ipv6.conf.default.disable_ipv6 = 1
   net.ipv6.conf.lo.disable_ipv6 = 1
In container, do sudo apt-get -o Acquire::ForceIPv4=true update
```

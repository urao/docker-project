#Bring up lxd containers on Ubuntu (14.04 trusty)

Steps to bring up lxd containers in privileged mode

1. apt install -t trusty-backports lxd lxd-client
2. lxd init
3. lxc launch ubuntu:16.04 helloc
4. Wait for couple of minutes to download the image
5. lxc list (List all the containers)
6. lxc exec helloc -- /bin/bash
7. Check if IP is assigned to the container, if not do, dhclient <veth-interface-name>
8. Login into container and try agt-get update, it tries to use IPv6 and will fail
9. On host, add below in /etc/sysctl.conf file and do sudo sysctl -p
   a. net.ipv6.conf.all.disable_ipv6 = 1
   b. net.ipv6.conf.default.disable_ipv6 = 1
   c. net.ipv6.conf.lo.disable_ipv6 = 1
10. In container, do sudo apt-get -o Acquire::ForceIPv4=true update

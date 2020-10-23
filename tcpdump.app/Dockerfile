FROM ubuntu:18.04
MAINTAINER urao@user.com

# Update
RUN apt-get update

# Install required pkgs
RUN apt-get install -y tcpdump
VOLUME /data

# Execute tcpdump
ENTRYPOINT ["/usr/sbin/tcpdump"]
CMD ["-C", "10000", "-W", "10", "-v", "-w", "/data/pktcapture"]

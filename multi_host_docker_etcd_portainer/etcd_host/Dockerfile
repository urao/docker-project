# Dockerfile to create etcd container
FROM ubuntu:14.04
MAINTAINER user@user.com

# Version
ENV ETCD_VERSION=v3.2.17

# Update
RUN apt-get update

# Install tools
RUN apt-get install -y iputils-ping curl tcpdump wget

# Working dir
WORKDIR /root/

# Get etcd
RUN wget https://github.com/coreos/etcd/releases/download/${ETCD_VERSION}/etcd-${ETCD_VERSION}-linux-amd64.tar.gz
RUN tar zxvf etcd-${ETCD_VERSION}-linux-amd64.tar.gz && cd etcd-${ETCD_VERSION}-linux-amd64 && chmod +x etcd etcdctl && cp etcd etcdctl /usr/local/bin

# Make data and cert folder
RUN mkdir -p /opt/etcd/{data,cert}


ARG ANSIBLE_VERSION=2.8.3 
FROM centos:centos7
MAINTAINER urao

# Install required pkgs
RUN yum update -y && \
    yum -y install epel-release && \
    yum install -y python-pip python-devel gcc gcc-c++ make openssl-devel \
        libffi-devel rsync sshpass git net-tools jq && \
    yum clean all

# Upgrade pip
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools

# Create default ansible directory
RUN mkdir /etc/ansible/
RUN echo -e '[local]\nlocalhost' > /etc/ansible/hosts

# Default workdir 
WORKDIR /ansible

# Volume 
VOLUME ["/ansible"]

# Install ansible
RUN pip install ansible==$ANSIBLE_VERSION

RUN pip install markupsafe httplib2 yamllint passlib
RUN pip install Jinja2 netaddr jmespath jxmlease \
        enum34 unique requests markupsafe httplib2 pika selenium passlib
RUN ansible-galaxy install Juniper.junos
RUN pip install --no-cache jsnapy


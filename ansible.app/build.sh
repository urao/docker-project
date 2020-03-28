#!/bin/bash
# Create ansible docker image with Junos ansible and jsnapy modules

echo "clean up old containers (if any)"
docker stop junos_ansible_app
docker rm junos_ansible_app

echo "Building new container"
docker build --build-arg ANSIBLE_VERSION=2.8.3 -t junos_ansible_app .

echo "Running new container in background"
docker run --rm junos_ansible_app ansible --version
echo "Output"
docker ps

exit 0

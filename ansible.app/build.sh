#!/bin/bash
# Create ansible docker image with Junos ansible and jsnapy modules

DOCKER_NAME="junos_ansible_app"

trap finish 1 2 3 6

function finish() {
  echo "Caught signal... cleanup."
  docker rm -f $DOCKER_NAME
  echo "Done cleaning ... quitting."
  exit 1
}
echo "clean up old containers (if any)"
docker stop $DOCKER_NAME
docker rm -f $DOCKER_NAME

echo "Building new container"
docker build --build-arg ANSIBLE_VERSION=2.8.3 -t $DOCKER_NAME .

echo "Running new container in background"
docker run --rm $DOCKER_NAME ansible --version

echo "Output"
docker ps

exit 0

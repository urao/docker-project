#!/bin/bash

echo "clean up old containers (if any)"
docker stop tcpdump_app
docker rm tcpdump_app

echo "Building new container"
docker build -t tcpdump_app .

echo "Running new container in background"
docker run --net=host --name tcpdump_app tcpdump_app
echo "Output"
docker ps

exit 0

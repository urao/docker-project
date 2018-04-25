#!/bin/bash

echo "clean up old containers (if any)"
docker stop example_app
docker rm example_app

echo "Building new container"
docker build -t example_app .

echo "Running new container in background"
docker run -d -p 8100:80 --name example_app example_app
echo "Output"
docker ps

exit 0

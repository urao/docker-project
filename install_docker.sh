#!/usr/bin/env bash
# Tested with Ubuntu 16.04 and Centos 7.4
set -e

EXITCODE=0

function deploy_on_ubuntu ()
{
   echo "Deploying docker on Ubuntu...."
   echo "First, remove existing version of docker"
   sudo apt-get remove -y docker docker-engine docker.io
   rm -rf /var/lib/docker

   echo "start installing.."
   sudo apt-get update -y
   sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   sudo apt-get update -y
   sudo apt-get install docker-ce

   echo "verify if docker installed correctly or not"
   sudo docker run hello-world
   RETVAL=$?
   if [ !$RETVAL ]; then
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      echo "Successfully deployed docker!!!!"
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
   else
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      echo "FAILED to deploy docker @@@@@"
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      EXITCODE=1
   fi
}

function deploy_on_centos ()
{
   echo "Deploying docker on Centos...."
   echo "First, remove existing version of docker"
   sudo yum remove -y docker docker-common docker-selinux docker-engine
   rm -rf /var/lib/docker

   sudo yum install -y yum-utils device-mapper-persistent-data lvm2
   sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
   sudo yum update -y
   sudo yum install -y docker-ce

   sudo systemctl start docker
   echo "verify if docker installed correctly or not"
   sudo docker run hello-world
   RETVAL=$?
   if [ !$RETVAL ]; then
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      echo "Successfully deployed docker!!!!"
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
   else
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      echo "FAILED FAILED to deploy docker !"
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      EXITCODE=1
   fi
}


if [ -f /etc/lsb-release ]; then
   deploy_on_ubuntu
elif [ -f /etc/redhat-release ]; then
   deploy_on_centos
else
   echo "Unsupported OS for now !!!"
   EXITCODE=1
fi

exit $EXITCODE

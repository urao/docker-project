#!/usr/bin/env bash
# Tested with Centos 7.4
set -e

EXITCODE=0
ETCD_VERSION=v3.2.1

function deploy_on_centos ()
{
   echo "Deploying etcd on Centos...."
   echo "First, remove existing version of docker"
   rm -rf /tmp/etcd-${ETCD_VERSION}-linux-amd64.tar.gz

   sudo yum update -y
   sudo yum install -y epel-release
   sudo yum install -y jq wget telnet net-tools curl util-linux

   DOWNLOAD_LINK=https://github.com/coreos/etcd/releases/download/${ETCD_VERSION}/etcd-${ETCD_VERSION}-linux-amd64.tar.gz
   curl -L ${DOWNLOAD_LINK} -o /tmp/etcd-${ETCD_VERSION}-linux-amd64.tar.gz

   tar zxvf /tmp/etcd-${ETCD_VERSION}-linux-amd64.tar.gz
   cd /tmp/etcd-${ETCD_VERSION}-linux-amd64
   mv etcd* /usr/local/bin

   HOSTNAME=`hostname -s`
   INTF=`ip route | grep default | awk '{print $5}'`
   PUBLIC_IP=`ifconfig ${INTF} | grep 'inet ' | awk '{print $2}'`

   echo "Create evironment file"
   cat << EOF > /etc/sysconfig/etcd
       ETCD_DATA_DIR=/var/lib/etcd
       ETCD_NAME=${HOSTNAME}
       ETCD_ADVERTISE_CLIENT_URLS="http://${PUBLIC_IP}:2379,http://${PUBLIC_IP}:4001"
       ETCD_LISTEN_CLIENT_URLS="http://0.0.0.0:2379,http://0.0.0.0:4001"
       ETCD_LISTEN_PEER_URLS="http://0.0.0.0:2380"
       ETCD_INITIAL_ADVERTISE_PEER_URLS="http://${PUBLIC_IP}:2380"
       ETCD_INITIAL_CLUSTER="${HOSTNAME}=http://${PUBLIC_IP}:2380"
       ETCD_INITIAL_CLUSTER_STATE=new
   EOF

   echo "Create etcd service file"
   cat << EOF > /usr/lib/systemd/system/etcd.service
      [Unit]
      Description=Etcd Server
      Documentation=https://github.com/coreos/etcd
      
      [Service]
      User=root
      ExecStart=/usr/local/bin/etcd 
      EnvironmentFile=-/etc/sysconfig/etcd
      NotifyAccess=all
      KillMode=process
      Restart=always
      
      [Install]
      WantedBy=multi-user.target
   EOF

   systemctl daemon-reload
   systemctl start etcd
   systemctl enable etcd

   SERVICE='etcd'
   sudo ps ax | grep -v grep | grep $SERVICE
   RETVAL=$?
   if [ !$RETVAL ]; then
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      echo "Successfully deployed $SERVICE!!!!"
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
   else
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      echo "FAILED FAILED to deploy $SERVICE !"
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      EXITCODE=1
   fi
}


if [ -f /etc/redhat-release ]; then
   deploy_on_centos
else
   echo "Unsupported OS for now !!!"
   EXITCODE=1
fi

exit $EXITCODE
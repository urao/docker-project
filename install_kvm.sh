#!/usr/bin/env bash
# Tested with Ubuntu 16.04 and Centos 7.4
set -e

EXITCODE=0

function deploy_on_ubuntu ()
{
   echo "Installing KVM and its packages...."
   sudo apt-get update -y
   sudo apt-get install -y qemu-kvm libvirt-bin virtinst bridge-utils cpu-checker libguestfs-tools

   echo "Verify KVM is installed"
   sudo kvm-ok
   RETVAL=$?
   if [ !$RETVAL ]; then
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      echo "Successfully installed KVM !!!!"
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
   else
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      echo "FAILED FAILED to install KVM !"
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      EXITCODE=1
   fi
  
   sudo apt-get install virt-manager -y
}

function deploy_on_centos ()
{
   echo "Installing KVM and its packages...."

   sudo yum install qemu-kvm qemu-img virt-manager libvirt libvirt-python libvirt-client virt-install virt-viewer bridge-utils libguestfs libguestfs-tools -y
   sudo systemctl start libvirtd
   sudo systemctl enable libvirtd

   echo "Verify KVM is installed"
   sudo lsmod | grep kvm
   RETVAL=$?
   if [ !$RETVAL ]; then
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      echo "Successfully installed KVM !!!!"
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
   else
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      echo "FAILED FAILED to install KVM !"
      echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      EXITCODE=1
   fi
   sudo yum install "@X Window System" xorg-x11-xauth xorg-x11-fonts-* xorg-x11-utils -y
   systemctl disable firewalld
   iptables -F
   sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config
   reboot
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

#! /bin/bash

ubuntu="/etc/lsb-release"
centos="/etc/redhat-release"

if [ -f $ubuntu ]
then
   echo "ubuntu"
elif [ -f $centos ]
then
   echo "centos"
else
   echo ""
fi

#! /bin/sh
curl -ssl https://raw.githubusercontent.com/king-aric/remote-scripts/master/python-pip/centos_pip.sh|sh
yum -y install gcc gcc-c++ python-devel libffi-devel  openssl openssl-devel
pip install flask gevent gevent-websocket websocket pyopenssl cryptography paramiko

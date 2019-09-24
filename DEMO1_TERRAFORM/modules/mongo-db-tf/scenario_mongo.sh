#!/bin/bash
MONGO_NETWORK_IP=$1
#sudo yum update -y

sudo sh -c 'cat << EOF >> /etc/yum.repos.d/mongodb-org-4.2.repo
[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc
EOF'

sudo yum install -y mongodb-org

sudo sed -i "s/127.0.0.1/${MONGO_NETWORK_IP}, 127.0.0.1/" /etc/mongod.conf

sudo systemctl start mongod

echo "All Done"

echo $MONGO_NETWORK_IP
#https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.2/x86_64/

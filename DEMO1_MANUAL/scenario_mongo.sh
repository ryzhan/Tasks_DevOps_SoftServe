#!/bin/bash

sudo yum update -y

sudo sh -c 'cat << EOF >> /etc/yum.repos.d/mongodb-org-4.2.repo
[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc
EOF'

sudo yum install -y mongodb-org

sudo sed -i 's/127.0.0.1/10.128.0.53,127.0.0.1/' /etc/mongod.conf

sudo systemctl start mongod

echo "All Done"

https://repo.mongodb.org/yum/redhat/7/mongodb-org/4.2/x86_64/

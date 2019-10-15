#!/bin/bash

sudo su -
yum install docker -y
systemctl start docker.service
systemctl enable docker.service
yum install git -y
git clone https://github.com/ryzhan/Tasks_DevOps_SoftServe.git
cd Tasks_DevOps_SoftServe
git checkout moodle/docker
cd Task2
docker build -t moodle/postgres .
docker run -d --name pg --restart always -p 5432:5432 moodle/postgres
#docker run -t -d --name pg1 -p 5432:5432 moodle/postgres
docker ps -a


#sed -i "s/listen_addresses = '*'/listen_addresses = '192.168.56.20'/" /var/lib/postgresql/data/postgresql.conf
#echo "host all all 192.168.56.10/32 md5" >> /var/lib/postgresql/data/pg_hba.conf
#!/bin/bash

sudo su -
yum install docker -y
systemctl start docker.service
systemctl enable docker.service
yum install git -y
git clone https://github.com/ryzhan/Tasks_DevOps_SoftServe.git
cd Tasks_DevOps_SoftServe
git checkout docker
cd Task2
docker build -t moodle/postgres ./db_postgres
docker run -d --name pg --restart always -p 5432:5432 moodle/postgres
docker ps -a

export IP_DB=$(docker inspect -f "{{ .NetworkSettings.IPAddress }}" pg)
docker build --build-arg IP_DOCKER_DB=$IP_DB -t moodle/lms -f ./lms_moodle
docker run -d --name lms --restart always -p 80:80 moodle/lms
docker ps -a

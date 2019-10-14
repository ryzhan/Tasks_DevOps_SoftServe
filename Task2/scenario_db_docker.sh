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
docker run -d --name pg -p 5432:5432 moodle/postgres



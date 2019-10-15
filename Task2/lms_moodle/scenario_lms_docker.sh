#!/bin/bash

sudo su -
yum install docker -y
systemctl start docker.service
systemctl enable docker.service
yum install git -y
git clone https://github.com/ryzhan/Tasks_DevOps_SoftServe.git
cd Tasks_DevOps_SoftServe
git checkout moodle/docker
cd Task2/lms_moodle
docker build -t moodle/lms .
docker run -d --name lms --restart always -p 80:80 moodle/lms
docker ps -a


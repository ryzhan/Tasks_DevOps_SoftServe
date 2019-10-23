#!/bin/bash
MONGO_NETWORK_IP=$1
sudo yum update -y
yum provides '*/applydeltarpm'
yum install deltarpm -y
sudo yum install epel-release -y
sudo su <<_EOF_
useradd -m jenkins
mkdir -p /home/jenkins/.ssh
chmod 700 /home/jenkins/.ssh
cat /tmp/id_rsa.pub >> /home/erkek/.ssh/authorized_keys
cat /tmp/id_rsa.pub >> /home/jenkins/.ssh/authorized_keys
chown jenkins:jenkins /home/jenkins/.ssh/ /home/jenkins/.ssh/authorized_keys
usermod -a -G adm,video,google-sudoers jenkins
_EOF_

sudo mkdir -p /opt/catalogue-db/data
sudo mkdir -p /opt/user-db/scripts
#echo "Install pip"
#sudo yum install python-pip -y
#sudo pip install --upgrade pip
#echo "Install pip docker"
#sudo pip install docker
echo "All Done"



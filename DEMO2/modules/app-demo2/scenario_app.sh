#!/bin/bash

MONGO_NETWORK_DB=$1
echo "DB IP $MONGO_NETWORK_DB"
#sudo yum update -y -q

sudo su <<_EOF_
useradd -m jenkins
mkdir -p /home/jenkins/.ssh
chmod 700 /home/jenkins/.ssh
cat /tmp/id_rsa.pub >> /home/erkek/.ssh/authorized_keys
cat /tmp/id_rsa.pub >> /home/jenkins/.ssh/authorized_keys
chown jenkins:jenkins /home/jenkins/.ssh/ /home/jenkins/.ssh/authorized_keys
usermod -a -G adm,video,google-sudoers jenkins
_EOF_

sudo chown jenkins:jenkins /tmp/*.sh
sudo chmod +x /tmp/*.sh
ls -la /tmp
echo "All Done"



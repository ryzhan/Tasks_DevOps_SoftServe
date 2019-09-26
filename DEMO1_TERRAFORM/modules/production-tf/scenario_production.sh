#!/bin/bash

MONGO_NETWORK_DB=$1

#sudo yum update -y -q

sudo yum install git -y 
sudo yum install java-1.8.0-openjdk -y 

sudo sh -c 'cat << EOF >> /usr/lib/systemd/system/carts.service
[Unit]
Description=Start ans Stop jar

[Service]
ExecStart=/usr/bin/java -jar -Ddb:carts-db=$MONGO_NETWORK_DB /home/jenkins/carts.jar
Restart=always
KillMode=control-group

[Install]
WantedBy=multi-user.target

EOF'

sudo sed -i "s/-Ddb:carts-db=/-Ddb:carts-db=${MONGO_NETWORK_DB}/" /usr/lib/systemd/system/carts.service

sudo systemctl daemon-reload 
sudo systemctl start carts
sudo systemctl enable carts
echo "Production Server"

sudo su <<_EOF_
useradd -m jenkins
mkdir -p /home/jenkins/.ssh
chmod 700 /home/jenkins/.ssh
cat /tmp/id_rsa.pub >> /home/jenkins/.ssh/authorized_keys
chown jenkins:jenkins /home/jenkins/.ssh/ /home/jenkins/.ssh/authorized_keys
exit
_EOF_


echo "All Done"
echo "Mongo db server ip $MONGO_NETWORK_DB"
echo "------"


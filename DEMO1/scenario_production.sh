#!/bin/bash

#sudo yum update -y -q

sudo yum install git -y 
sudo yum install java-1.8.0-openjdk -y 

sudo sh -c 'cat << EOF >> /usr/lib/systemd/system/carts.service
[Unit]
Description=Start ans Stop jar

[Service]
ExecStart=/usr/bin/java -jar -Ddb:carts-db=10.128.0.53 /home/jenkins/carts.jar
KillMode=control-group

[Install]

EOF'

sudo systemctl daemon-reload 
sudo systemctl enable carts

echo "All Done"



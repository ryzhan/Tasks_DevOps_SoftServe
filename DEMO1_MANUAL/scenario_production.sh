#!/bin/bash

#sudo yum update -y -q

sudo yum install git -y -q
sudo yum install java-1.8.0-openjdk -y -q

sudo sh -c 'cat << EOF >> /usr/lib/systemd/system/carts.service
[Unit]
Description=Start ans Stop jar

[Service]
ExecStart=/usr/bin/java -jar -Ddb:carts-db=10.128.0.53 /home/jenkins/carts.jar
Restart=always
KillMode=control-group

[Install]
WantedBy=multi-user.target

EOF'

sudo systemctl daemon-reload 
sudo systemctl start carts
sudo systemctl enable carts

echo "All Done"



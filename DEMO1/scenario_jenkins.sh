#!/bin/bash

#sudo yum update -y 

sudo yum install git -y 
sudo yum install java-1.8.0-openjdk -y 

sudo yum install maven -y 
sudo sh -c 'cat << EOF >> /etc/profile.d/maven.sh
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.222.b10-1.el7_7.x86_64/jre/
export M2_HOME=/usr/share/maven/
export MAVEN_HOME=/usr/share/maven/
export PATH=${M2_HOME}/bin:${PATH}
EOF'
sudo chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh


curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install jenkins -y 
sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "All Done"




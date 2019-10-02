#!/bin/bash

#sudo yum update -y 
PRODUCTION_NETWORK_IP=$1

sudo yum install git -y -q
sudo yum install java-1.8.0-openjdk -y -q

sudo yum install maven -y -q
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

echo "Jenkins server"


sudo sh -c "cat << EOF >> /var/lib/jenkins/production_local_ip
$PRODUCTION_NETWORK_IP
EOF"

sudo su <<_EOF_

mkdir -p /var/lib/jenkins/.ssh
chmod 700 /var/lib/jenkins/.ssh
mv /tmp/id_rsa /var/lib/jenkins/.ssh/
mv /tmp/id_rsa.pub /var/lib/jenkins/.ssh/
ssh-keyscan -H ${PRODUCTION_NETWORK_IP} >> /var/lib/jenkins/.ssh/known_hosts
chown jenkins:jenkins /var/lib/jenkins/.ssh /var/lib/jenkins/.ssh/id_rsa /var/lib/jenkins/.ssh/id_rsa.pub /var/lib/jenkins/.ssh/known_hosts
chmod 600 /var/lib/jenkins/.ssh/id_rsa
chmod 600 /var/lib/jenkins/.ssh/id_rsa.pub
exit
_EOF_

echo "Production server ip ${PRODUCTION_NETWORK_IP}"
echo "All Done"
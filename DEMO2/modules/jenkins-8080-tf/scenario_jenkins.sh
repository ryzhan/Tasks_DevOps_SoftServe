#!/bin/bash

sudo yum update -y 
APP_NETWORK_IP=$1
DB_NETWORK_IP=$2

sudo yum install git -y -q
sudo yum install java-1.8.0-openjdk -y -q


sudo yum install maven -y -q
sudo sh -c 'cat << EOF >> /etc/profile.d/maven.sh
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.222.b10-1.el7_7.x86_64/jre/
#export JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk-1.8.0.232.b09-0.el7_7.x86_64
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
$APP_NETWORK_IP
EOF"
sudo sh -c "cat << EOF >> /var/lib/jenkins/db_local_ip
$DB_NETWORK_IP
EOF"

sudo sh -c "echo '$DB_NETWORK_IP db-server' >> /etc/hosts"
sudo sh -c "echo '$APP_NETWORK_IP app-server' >> /etc/hosts"
export ip_db_server=$DB_NETWORK_IP

sudo su <<_EOF_
mkdir -p /var/lib/jenkins/.ssh
chmod 700 /var/lib/jenkins/.ssh
cat /tmp/id_rsa >> /home/erkek/.ssh/id_rsa
ssh-keyscan -H ${APP_NETWORK_IP} >> /home/erkek/.ssh/known_hosts
mv /tmp/id_rsa /var/lib/jenkins/.ssh/
mv /tmp/id_rsa.pub /var/lib/jenkins/.ssh/
ssh-keyscan -H ${APP_NETWORK_IP} >> /var/lib/jenkins/.ssh/known_hosts
ssh-keyscan -H app-server >> /var/lib/jenkins/.ssh/known_hosts
chown jenkins:jenkins /var/lib/jenkins/.ssh /var/lib/jenkins/.ssh/id_rsa /var/lib/jenkins/.ssh/id_rsa.pub /var/lib/jenkins/.ssh/known_hosts
chmod 600 /var/lib/jenkins/.ssh/id_rsa
chmod 600 /var/lib/jenkins/.ssh/id_rsa.pub
exit
_EOF_



sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io -y
sudo yum install ansible -y
sudo yum install python-pip -y
sudo pip install --upgrade pip
sudo pip install docker
sudo mkdir -p /opt/ansible 
sudo mv /tmp/ansible.tar /opt/ansible/ansible.tar
cd /opt/ansible
sudo tar -xzf ansible.tar
sudo sh -c "cat << EOF >> /opt/ansible/hosts.txt
[app]
app-server ansible_host=$APP_NETWORK_IP 

[db]
db-server ansible_host=$DB_NETWORK_IP

[server_all:children]
app
db
EOF"

ansible-playbook docker.yml

echo "All Done"
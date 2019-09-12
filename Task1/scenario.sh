#!/bin/bash

sudo apt-get update 

sudo sh -c 'cat << EOF >> /etc/default/locale
LANGUAGE=en_US.UTF-8
LC_ALL=en_US.UTF-8
LANG=en_US.UTF-8
LC_TYPE=en_US.UTF-8
EOF'
export LC_ALL=en_US.UTF-8
sudo update-locale "LANG=en_US.UTF-8"
sudo locale-gen --purge "en_US.UTF-8"
sudo dpkg-reconfigure --frontend noninteractive locales
sudo apt install git -y -q
sudo apt install openjdk-8-jdk -y -q

sudo apt install maven -y -q
sudo sh -c 'cat << EOF >> /etc/profile.d/maven.sh
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
export M2_HOME=/usr/share/maven/
export MAVEN_HOME=/usr/share/maven/
export PATH=${M2_HOME}/bin:${PATH}
EOF'
sudo chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh

wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update -q
sudo apt install jenkins -y -q
sudo systemctl start jenkins
sudo systemctl enable jenkins
echo "All Done"




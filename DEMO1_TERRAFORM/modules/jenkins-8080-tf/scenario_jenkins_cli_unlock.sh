#!/bin/bash

sudo su <<_EOF_
mkdir /var/lib/jenkins/init.groovy.d
cp /tmp/disable_wizzard /var/lib/jenkins/init.groovy.d/basic-security.groovy
systemctl restart jenkins
sleep 30
rm -rf /var/lib/jenkins/init.groovy.d/basic-security.groovy

echo "Wizzard disable"

cp /tmp/add_user_jenkins /var/lib/jenkins/init.groovy.d/basic-security.groovy
systemctl restart jenkins
sleep 30
rm -rf /var/lib/jenkins/init.groovy.d/basic-security.groovy
echo "User add"
echo "Done"
exit
_EOF_

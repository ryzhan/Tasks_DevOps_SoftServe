#!/bin/bash


# sudo sh -c "cat << EOF >> /var/lib/jenkins/production_local_ip
# $APP_NETWORK_IP
# EOF"
# sudo sh -c "cat << EOF >> /var/lib/jenkins/db_local_ip
# $DB_NETWORK_IP
# EOF"

# sudo sh -c "echo '$DB_NETWORK_IP db-server' >> /etc/hosts"
# sudo sh -c "echo '$APP_NETWORK_IP app-server' >> /etc/hosts"
# export ip_db_server=$DB_NETWORK_IP

sudo su <<_EOF_
mkdir -p /var/lib/jenkins/.ssh
mkdir -p /var/lib/jenkins/credential
chmod 700 /var/lib/jenkins/credential
chmod 700 /var/lib/jenkins/.ssh
mv /tmp/if-101-demo1-02c2a2eae285.json /var/lib/jenkins/credential/
mv /tmp/read-registry.json /var/lib/jenkins/credential/
#mv /tmp/id_rsa /var/lib/jenkins/.ssh/
#mv /tmp/id_rsa.pub /var/lib/jenkins/.ssh/
#chmod 600 /var/lib/jenkins/.ssh/id_rsa
#chmod 600 /var/lib/jenkins/.ssh/id_rsa.pub
ssh-keygen -P '' -f /var/lib/jenkins/.ssh/id_rsa -C jenkins

#ssh-keyscan -H app-server >> /var/lib/jenkins/.ssh/known_hosts
#ssh-keyscan -H db-server >> /var/lib/jenkins/.ssh/known_hosts
# sed -i -e 's/JENKINS_USER\="jenkins"/JENKINS_USER\="root"/g' /etc/sysconfig/jenkins
chown -R jenkins:jenkins /var/lib/jenkins
# chown -R root:root /var/cache/jenkins
# chown -R root:root /var/log/jenkins
# systemctl restart jenkins
exit
_EOF_


echo "All Done"
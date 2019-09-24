DEMO1:

 1.Create and configure Build Server
 
 2.Create VM instance on Google Cloud Platform (GCP) [manually]
 
 3.Install all needed software for Jenkins

    a.Java Development Kit (JDK)
 
    b.Apache Maven

    c.Jenkins (can be installed from .rpm package)

    d.Git

    i.Create Jenkins project for git@github.com:microservices-demo/carts.git
       
        
 4.Copy created artifact to production server via Execute shell and run it

 5.Create a DB Mongo server

 Access to the VM instance should be provided via SSH keys


-Create VM instance(name=jenkins-8080) on Google Cloud Platform with Centos7

-Add SSH keys from home_host to instance(jenkins-8080), and create rule firewall to open 8080 port(tags=jenkins-8080)

-Copy scenario.sh on instanse(jenkins-8080) via scp and run scipt via SSH
    `scp scenario_jenkins.sh your_user@nat_ip_address:~`
     for example `scp scenario_jenkins.sh erkek@35.188.142.15:~`

    `ssh your_user@nat_ip_address source ~/scenario_jenkins.sh`
    for example`ssh erkek@35.188.142.15 source ~/scenario_jenkins.sh`

-Copy Jenkins Unlock Key from terminal
    `ssh erkek@35.226.174.126 cat /var/lib/jenkins/secrets/initialAdminPassword`
    for example`ssh erkek@35.226.174.126 cat /var/lib/jenkins/secrets/initialAdminPassword`

-To set up our installation, we’ll visit Jenkins by opening web browser and open the link below.
`http://nat_ip_address_or_domain_name:8080`

-Install suggested plugins

-Create first admin user

-Fork a repos  git@github.com:microservices-demo/carts.git
`https://github.com/ryzhan/carts.git`

#-Generating a new SSH key on instance(jenkins-8080) and adding it to your GitHub account
#`ssh-keygen`
#`sudo cat ~/.ssh/id_rsa.pub`

-Generating a new SSH key for user jenkins on instance(jenkins-8080)
    `sudo su -s /bin/bash jenkins`
    `ssh-keygen`
    -add local_ip from instances (prodaction) ssh/known_hosts
    `ssh-keyscan -H ip_address_production_instance >> ~/.ssh/known_hosts`
    for example `ssh-keyscan -H 10.128.0.50 >> ~/.ssh/known_hosts`
    `sudo cat ~/.ssh/id_rsa.pub`

-Create separate production instance(name=production) and 
    - Add SSH keys from home_host
    - Add SSH keys on instance(production) for user jenkins from instance(jenkins-8080)

    -Create rule firewall to open 8081 port(tags=production)
    -Copy scenario_production.sh on instanse(production) via scp 
    `scp scenario_production.sh your_user@nat_ip_address_or_domain_name:~`
     for example `scp scenario_production.sh erkek@34.70.37.128:~`
     
     -run script
     `ssh your_user@nat_ip_address source ~/scenario_production.sh`
     for example `ssh erkek@34.70.37.128 source ~/scenario_production.sh`



--Create third instance(name=mongo-db) for Database MongoDB 
    -Create rule firewall to open 27017 port(tags=mongo)
    -Copy scenario_mongo.sh on instanse(production) via scp
    `scp scenario_mongo.sh your_user@nat_ip_address_or_domain_name:~`
     for example `scp scenario_mongo.sh erkek@35.184.232.213:~`
     
     -run script
     `ssh your_user@nat_ip_address source ~/scenario_mongo.sh`
     for example `ssh erkek@35.184.232.213 source ~/scenario_mongo.sh`

    
-Create new job (name=jenkins-test-java)

- Under Source Code Management, Enter your repository URL. We have a test repository located at
`https://github.com/ryzhan/JavaSimpleProj.git`

-Build Triggers --> Poll SCM --> H/2 * * * *        (it's meen every two minute jenkins check github)

-Build --> Invoke top-level Maven targets --> package

-Execute shell --> 
`ssh jenkins@10.128.0.50 sudo systemctl stop carts`
`scp /var/lib/jenkins/workspace/jenkins-test-java/target/carts.jar jenkins@10.128.0.50:~`
`ssh jenkins@10.128.0.50 sudo systemctl start carts`
#`ssh jenkins@10.128.0.9 nohup java -jar -Ddb:carts-db=10.128.0.53 /home/jenkins/carts.jar &`


or 

#`scp /var/lib/jenkins/workspace/jenkins-test-java/target/carts.jar root@10.128.0.50:~`
#`ssh -f root@10.128.0.50 'sudo su; java -jar -Ddb:carts-db=10.128.0.53 /root/carts.jar`

-Save and Build project. 
Building jar is here: 
`/var/lib/jenkins/workspace/jenkins-test-java/target/carts.jar`



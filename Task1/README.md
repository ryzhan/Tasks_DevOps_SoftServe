Task1:

 1.Create and configure Build Server
 
 2.Create VM instance on Google Cloud Platform (GCP) [manually]
 
 3.Install all needed software for Jenkins

    a.Java Development Kit (JDK)
 
    b.Apache Maven

    c.Jenkins (can be installed from .rpm package)

    d.Create Jenkins project for https://github.com/yurkovskiy/JavaSimpleProj.git
       
        i. It would be better to work this repo under your GitHub account
 4.Copy created artifact to production server via Execute shell and run it

 Access to the VM instance should be provided via SSH keys



-Create VM instance(name=jenkins-8080) on Google Cloud Platform with Centos7

-Add SSH keys on instance(jenkins-8080), and create rule firewall to open 8080 port

-Copy scenario.sh on instanse(jenkins-8080) via scp
`scp scenario_jenkins.sh your_user@ip_address_or_domain_name:~`
for example `scp scenario_jenkins.sh erkek@35.193.206.226:~`

-Connect to instance(jenkins-8080) via SSH:
    -run script
    `source ~/scenario.sh`

    -Copy Jenkins Unlock Key from terminal
    `sudo cat /var/lib/jenkins/secrets/initialAdminPassword`

-To set up our installation, we’ll visit Jenkins by opening web browser and open the link below.
`http://ip_address_or_domain_name:8080`

-Install suggested plugins

-Create first admin user

-Fork a repos  https://github.com/yurkovskiy/JavaSimpleProj.git and fix automation tests
`https://github.com/ryzhan/JavaSimpleProj.git`

#-Generating a new SSH key on instance(jenkins-8080) and adding it to your GitHub account
#`ssh-keygen`
#`sudo cat ~/.ssh/id_rsa.pub`

-Create separate production instance(name=production) and add SSH keys
-Copy scenario.sh on instanse(production) via scp
`scp scenario_production.sh your_user@ip_address_or_domain_name:~`
for example `scp scenario_production.sh erkek@35.188.65.40:~`

-Connect to instance(production) via SSH:
    -run script
    `source ~/scenario_production.sh`

-Generating a new SSH key for user jenkins on instance(jenkins-8080)
`sudo su -s /bin/bash jenkins`
`ssh-keygen -R ip_address_production_instance`
for example `ssh-keygen -R 10.128.0.9`
`ssh-keyscan -H ip_address_production_instance >> ~/.ssh/known_hosts`
for example `ssh-keyscan -H 10.128.0.9 >> ~/.ssh/known_hosts`
#`ssh-keyscan -H ip_address_production_instance >> .ssh/authorized_keys`
`sudo cat ~/.ssh/id_rsa.pub`

- Add SSH keys on instance(production) for user jenkins from instance(jenkins-8080)


-Create new job

- Under Source Code Management, Enter your repository URL. We have a test repository located at
`https://github.com/ryzhan/JavaSimpleProj.git`

-Build Triggers --> Poll SCM --> H/2 * * * *        (it's meen every two minute jenkins check github)

-Build --> Invoke top-level Maven targets --> package

-Execute shell --> 
`scp /var/lib/jenkins/workspace/jenkins-test-java/target/com.yurkovskiy-1.0-SNAPSHOT.jar jenkins@10.128.0.9:~`
`ssh jenkins@10.128.0.9 java -jar /home/jenkins/com.yurkovskiy-1.0-SNAPSHOT.jar`

-Save and Build project.Building jar: 
`/var/lib/jenkins/workspace/jenkins-test-java/target/com.yurkovskiy-1.0-SNAPSHOT.jar`

#ssh -o StrictHostKeyChecking=no jenkins@10.128.0.9


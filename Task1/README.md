Task1:

 1.Create and configure Build Server
 
 2.Create VM instance on Google Cloud Platform (GCP) [manually]
 
 3.Install all needed software for Jenkins

    a.Java Development Kit (JDK)
 
    b.Apache Maven

    c.Jenkins (can be installed from .rpm package)

    d.Create Jenkins project for https://github.com/yurkovskiy/JavaSimpleProj.git
       
        i. It would be better to work this repo under your GitHub account

 Access to the VM instance should be provided via SSH keys



-Create VM instance on Google Cloud Platform with Centos7

-Add SSH keys on instance, and create rule firewall to open 8080 port

-Copy scenario.sh on instanse via scp
`scp scenario.sh your_user@ip_address_or_domain_name:/tmp`
`scp scenario.sh erkek@130.211.233.111:/tmp`

-Connect to instance via SSH, and run script
`source /tmp/scenario.sh`

-Copy Jenkins Unlock Key from terminal
`sudo cat /var/lib/jenkins/secrets/initialAdminPassword`

-To set up our installation, we’ll visit Jenkins by opening web browser and open the link below.
`http://ip_address_or_domain_name:8080`

-Install suggested plugins

-Create first admin user

-Fork a repos  https://github.com/yurkovskiy/JavaSimpleProj.git and fix automation tests
`https://github.com/ryzhan/JavaSimpleProj.git`

-Generating a new SSH key on instance and adding it to your GitHub account
`ssh-keygen`
`sudo cat ~/.ssh/id_rsa.pub`

-Create new job

- Under Source Code Management, Enter your repository URL. We have a test repository located at
`https://github.com/ryzhan/JavaSimpleProj.git`

-Build Triggers --> Poll SCM --> H/2 * * * *        (it's meen every two minute jenkins check github)

-Build --> Invoke top-level Maven targets --> package

-Save and Build project.Building jar: 
`/var/lib/jenkins/workspace/jenkins-test/target/com.yurkovskiy-1.0-SNAPSHOT.jar`

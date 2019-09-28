#!/bin/bash

sudo su <<_EOF_
mkdir /var/lib/jenkins/init.groovy.d
cp /tmp/disable_wizzard /var/lib/jenkins/init.groovy.d/basic-security.groovy
sleep 10
systemctl restart jenkins
sleep 45
rm -rf /var/lib/jenkins/init.groovy.d/basic-security.groovy

echo "Jenkins start up wizzard disable"

cp /tmp/add_user_jenkins /var/lib/jenkins/init.groovy.d/basic-security.groovy
systemctl restart jenkins
sleep 45
rm -rf /var/lib/jenkins/init.groovy.d/basic-security.groovy
echo "User add"

java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -auth admin:admin -s "http://localhost:8080/" install-plugin trilead-api `
`jdk-tool workflow-support script-security command-launcher workflow-cps bouncycastle-api handlebars  locale `
`javadoc momentjs structs workflow-step-api scm-api workflow-api junit apache-httpcomponents-client-4-api `
`pipeline-input-step display-url-api mailer credentials ssh-credentials jsch maven-plugin git-server token-macro `
`pipeline-stage-step run-condition matrix-project conditional-buildstep parameterized-trigger git git-client `
`workflow-scm-step cloudbees-folder timestamper pipeline-milestone-step workflow-job jquery-detached jackson2-api `
`branch-api ace-editor pipeline-graph-analysis pipeline-rest-api pipeline-stage-view pipeline-build-step `
`plain-credentials credentials-binding pipeline-model-api pipeline-model-extensions workflow-cps-global-lib `
`workflow-multibranch authentication-tokens docker-commons durable-task workflow-durable-task-step `
`workflow-basic-steps docker-workflow pipeline-stage-tags-metadata pipeline-model-declarative-agent `
`pipeline-model-definition workflow-aggregator lockable-resources -deploy
exit
echo "Plugin install"
_EOF_

sudo su <<_EOF_
echo"--------------"
sleep 30
java -jar /var/cache/jenkins/war/WEB-INF/jenkins-cli.jar -auth admin:admin -s "http://localhost:8080/" safe-restart
#systemctl restart jenkins
echo "Jenkins restart"
_EOF_

echo "Job Add "
echo "All Done"
exit

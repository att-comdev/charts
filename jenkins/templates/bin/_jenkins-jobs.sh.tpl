#!/bin/bash
sleep 300

{{- $securityRealm := .Values.conf.config.jenkins.securityrealm -}}

set -xe
cd ~

# wait for jenkins
printf Waiting for Jenkins to get online
until $(curl -o /dev/null -sLf {{ .Values.conf.location_config.jenkinsUrl }} ); do
    printf '.'
    sleep 5
done
echo

# get effective jenkins url
export JENKINS_URL=$(curl -w "%{url_effective}" -o /dev/null -Ls {{ .Values.conf.location_config.jenkinsUrl }})
echo Resolved jenkins url: $JENKINS_URL

# execute preseed script to create superseed job
curl $JENKINS_URL/jnlpJars/jenkins-cli.jar -o ~/cli.jar
java -jar ~/cli.jar -webSocket -auth {{ $securityRealm.manager_dn }}:{{ $securityRealm.password }} groovy = < /tmp/preseed.groovy\
 https://review.gerrithub.io/att-comdev/cicd refs/changes/06/550806/8 cicd/SuperSeed/seed.groovy
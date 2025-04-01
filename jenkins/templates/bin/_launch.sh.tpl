#!/bin/bash

{{/*
Copyright 2018 The Openstack-Helm Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/}}

# NOTE: no -e by design, some of this can/will fail, and that's OK
set -x

keytool -delete -alias JENKINS-CONTROLLER-CERT -keystore /var/jenkins_home/JenkinsKeystore -storepass changeit || true
keytool -import -alias JENKINS-CONTROLLER-CERT -keystore /var/jenkins_home/JenkinsKeystore -file /var/jenkins_home/ca.crt -storepass changeit -noprompt

if [ -e /var/jenkins_home/plugins_downloaded ] ; then
   rm /var/jenkins_home/plugins_downloaded
fi

{{ if .Values.plugins.enabled -}}

rm -rf /tmp/plugins*
if [ $(curl -s -w"%{http_code}" -o /tmp/plugins.tar.gz {{ .Values.plugins.url }})=="200" ] \
    && tar xzf /tmp/plugins.tar.gz -C /tmp \
    && [ -d /tmp/plugins ] \
    && [ ! -z "$(ls -A /tmp/plugins)" ]
then
    rm -rf /var/jenkins_home/plugins
    mv /tmp/plugins /var/jenkins_home/
else
    echo "[ERROR] Something went wrong while fetching plugins. Check the logs above."
fi

rm -rf /tmp/plugins*

{{- else -}}

# review: this will not work in new versions because
# install-plugins.sh script is no longer supplied in jenkins images
if [ -e /plugins.txt ] ; then

    # FIXME(cw): transitional, file should never have been there
    rm -f ~/plugins.txt

    # put a dummy-lock file in place so that if install-plugins.sh finds
    # at least something to cleanup and doesn't error out
    mkdir -p /usr/share/jenkins/ref/plugins/ && touch /usr/share/jenkins/ref/plugins/zzz-dummy.lock
    /usr/local/bin/install-plugins.sh $(cat /plugins.txt)
fi
{{- end }}

# Plugins downloaded
touch /var/jenkins_home/plugins_downloaded

# generate ssh key if we don't have one already
KFILE=~/.ssh/id_ed25519
if [ ! -e "${KFILE}" ] ; then
    ssh-keygen -q -t ed25519 -f ${KFILE} -N ""
fi

# allow ssh-rsa that is disabled by default in recent versions
if ! ssh -G * | grep ^pubkeyaccepted | grep ssh-rsa || ! ssh -G * | grep ^hostkeyalgorithms | grep ssh-rsa
then
    echo >> $JENKINS_HOME/.ssh/config && \
    echo "Host *" >> $JENKINS_HOME/.ssh/config && \
    echo "    PubkeyAcceptedKeyTypes=+ssh-rsa" >> $JENKINS_HOME/.ssh/config && \
    echo "    HostKeyAlgorithms=+ssh-rsa" >> $JENKINS_HOME/.ssh/config
fi

# remove proxy settings
rm /var/jenkins_home/proxy.xml

{{- if .Values.conf.config.jenkins.useProxy}}
# generate proxy settings file
python3 proxy-config-gen.py
{{- else}}
# remove update info because update through jenkins is disabled
rm /var/jenkins_home/updates/default.json
{{- end}}

JAVA_OPTS="$JAVA_OPTS -Dorg.jenkinsci.plugins.workflow.cps.LoggingInvoker.fieldSetWarning=false" exec /usr/bin/tini -- /usr/local/bin/jenkins.sh
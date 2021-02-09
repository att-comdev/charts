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

{{ if .Values.plugins.enabled -}}

[ -d /var/jenkins_home/plugins/ ] && rm -rf /var/jenkins_home/plugins/
curl -o /var/jenkins_home/plugins.tar.gz {{ .Values.plugins.url }}
tar xzf /var/jenkins_home/plugins.tar.gz -C /var/jenkins_home/
rm /var/jenkins_home/plugins.tar.gz
{{- else -}}

if [ -e /plugins.txt ] ; then

    # FIXME(cw): transitional, file should never have been there
    rm -f ~/plugins.txt

    # put a dummy-lock file in place so that if install-plugins.sh finds
    # at least something to cleanup and doesn't error out
    [ -d /var/jenkins_home/plugins/ ] && rm -rf /var/jenkins_home/plugins/
    mkdir -p /usr/share/jenkins/ref/plugins/ && touch /usr/share/jenkins/ref/plugins/zzz-dummy.lock
    /usr/local/bin/install-plugins.sh $(cat /plugins.txt)
fi
{{- end }}

# proxy.xml configuration from environment variables
rm -fv /var/jenkins_home/proxy.xml
python proxy-config-gen.py

# generate ssh key if we don't have one already
KFILE=~/.ssh/id_ed25519
if [ ! -e "${KFILE}" ] ; then
    ssh-keygen -q -t ed25519 -f ${KFILE} -N ""
fi

exec /sbin/tini -- /usr/local/bin/jenkins.sh

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

set -ex

# seed the (jenkins home) PVC with files *iff* they do not exist (-n
# avoids replacing files)
cp -nrv /seed/* /var/jenkins_home/

{{- if .Values.conf.gerrit_trigger.enable }}
# Add ssh keys for gerrit trigger.
mkdir -p /var/jenkins_home/.ssh
{{- if .Values.conf.git_client_config.manualKeysFromKnownHostsSystemParam }}
! [ -s /var/jenkins_home/.ssh/known_hosts ] && echo -e {{ .Values.conf.config.jenkins.global_env_vars.known_hosts | quote }} > /var/jenkins_home/.ssh/known_hosts
{{- end }}
{{- range .Values.conf.gerrit_trigger.servers }}
{{- if .gerrit_authkey_path }}
cp -nvpL /keys/id_rsa_{{ .name }} /var/jenkins_home/.ssh/{{ .gerrit_authkey_path }}
{{- else }}
cp -nvpL /keys/id_rsa_{{ .name }} /var/jenkins_home/.ssh/id_rsa_{{ .name }}
{{- end }}
{{- end }}
{{- end }}

# copy jenkins css file
mkdir -p /var/jenkins_home/init.groovy.d/
cp -fv /tmp/relaxed-CSP.groovy /var/jenkins_home/init.groovy.d/relaxed-CSP.groovy

# copy artifactory css issue fix solution
cp -fv /tmp/artifactory-css.groovy /var/jenkins_home/init.groovy.d/artifactory-css.groovy

# the seed runs as root; everything else runs as jenkins so we have to
# make sure the permissions are as expected
find /var/jenkins_home/ -not -user jenkins -print0 | xargs -r0 chown -v jenkins:jenkins

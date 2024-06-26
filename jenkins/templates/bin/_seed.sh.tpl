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

# this is a temporary solution for the upgrade
# todo: remove this when nc v2.12 will no longer be supported
cp -f /seed/audit-trail.xml /var/jenkins_home/
cp -f /seed/org.jfrog.hudson.ArtifactoryBuilder.xml /var/jenkins_home/

{{- if .Values.conf.gerrit_trigger.enable }}
# Add ssh keys for gerrit trigger.
mkdir -p /var/jenkins_home/.ssh
{{- if .Values.conf.known_hosts.override }}
{{- if .Values.conf.known_hosts.keysFromKnownHostsSystemParam }}
# create known_hosts from global_env_vars.known_hosts
echo -e {{ .Values.conf.config.jenkins.global_env_vars.known_hosts | quote }} > /var/jenkins_home/.ssh/known_hosts
{{ else }}
# create known_hosts from content
echo -e {{ .Values.conf.known_hosts.content | quote }} > /var/jenkins_home/.ssh/known_hosts
{{- end }}
{{ else }}
# create known_hosts file if doesnt exists or if it exists and the size is 0 from global_env_vars.known_hosts
{{- if .Values.conf.known_hosts.keysFromKnownHostsSystemParam }}
! [ -s /var/jenkins_home/.ssh/known_hosts ] && echo -e {{ .Values.conf.config.jenkins.global_env_vars.known_hosts | quote }} > /var/jenkins_home/.ssh/known_hosts
{{ else }}
! [ -s /var/jenkins_home/.ssh/known_hosts ] && echo -e {{ .Values.conf.known_hosts.content | quote }} > /var/jenkins_home/.ssh/known_hosts
{{- end }}
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

# copy pipeline utility steps properties
cp -fv /tmp/pipeline-utility-steps.groovy /var/jenkins_home/init.groovy.d/pipeline-utility-steps.groovy

# copy jobs init script
cp -fv /tmp/preseed.groovy /var/jenkins_home/init.groovy.d/preseed.groovy

# copy script that takes care of jenkins warnings
cp -fv /tmp/disable_irrelevant_warnings.groovy /var/jenkins_home/init.groovy.d/disable_irrelevant_warnings.groovy

{{- if not .Values.conf.config.jenkins.useProxy}}
# copy disable proxy script
cp -fv /tmp/disable_proxy.groovy /var/jenkins_home/init.groovy.d/disable_proxy.groovy
{{- else }}
# remove disable proxy script
rm /var/jenkins_home/init.groovy.d/disable_proxy.groovy || true
{{- end }}

# remove badge plugin config file (the new one with default settings will be recreated by jenkins)
# this is needed because older config has different format and it triggers warning in jenkins after update
rm /var/jenkins_home/com.jenkinsci.plugins.badge.BadgePlugin.xml || true

# the seed runs as root; everything else runs as jenkins so we have to
# make sure the permissions are as expected
{{- if .Values.conf.seed.change_owner_for_all_files }}
find /var/jenkins_home/ -not -user jenkins -print0 | xargs -r0 chown -v jenkins:jenkins
{{- else }}
# Exclude 'jobs' and 'workspace' folders because seed doesn't touch them and they may contain millions of files
# 'find' enumerates over all directories (and takes a lot of time) even if some path is excluded
# so it's better to start with the list of paths that doesn't contain excluded folders
chown -v jenkins:jenkins /var/jenkins_home/
find /var/jenkins_home/ -maxdepth 1 -mindepth 1 -not -ipath '/var/jenkins_home/jobs' -not -ipath '/var/jenkins_home/workspace' -print0 | \
xargs -r0 -I {term} find {term} -not -user jenkins -print0 | \
xargs -r0 chown -v jenkins:jenkins
{{- end }}
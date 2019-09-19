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
cp -nv /seed/* /var/jenkins_home/
#Create the SuperSeed job config structure and put the config.xml in respective places
mkdir -p /var/jenkins_home/jobs/CICD/jobs/SuperSeed
mv -nv /seed/cicdfolderconfig.xml /var/jenkins_home/jobs/CICD/config.xml
mv -nv /seed/superseedconfig.xml /var/jenkins_home/jobs/CICD/jobs/SuperSeed/config.xml

# copy jenkins css file
mkdir -p /var/jenkins_home/init.groovy.d/
cp -fv /tmp/relaxed-CSP.groovy /var/jenkins_home/init.groovy.d/relaxed-CSP.groovy

# the seed runs as root; everything else runs as jenkins so we have to
# make sure the permissions are as expected
find /var/jenkins_home/ -not -user jenkins -print0 | xargs -r0 chown -v jenkins:jenkins

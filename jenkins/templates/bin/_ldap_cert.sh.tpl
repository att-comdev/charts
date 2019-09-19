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

set -x

env_type={{.Values.conf.config.jenkins.ldap.env_type}}
copy_cert={{.Values.conf.config.jenkins.ldap.copy_cert}}
prod_cert_url={{.Values.conf.config.jenkins.ldap.prod_cacert_url}}
nonprod_cert_url={{.Values.conf.config.jenkins.ldap.nonprod_cacert_url}}
artifactory_key={{.Values.conf.config.jenkins.ldap.artif_key}}

if [[ "$env_type" = "prod" ]]; then
  certificate_url=$prod_cert_url
else
  certificate_url=$nonprod_cert_url
fi

if [[ "$copy_cert" = "true" ]]; then
  mkdir -p $JENKINS_HOME/certificate
  wget $certificate_url -O $JENKINS_HOME/certificate/SBC-Ent-Root-CA.cer --header="Authorization:Basic $artifactory_key" || true
  cp $JAVA_HOME/jre/lib/security/cacerts $JAVA_HOME/jre/lib/security/cacerts.$(date +"%m%d%y")
  keytool -import -alias SBC-Ent-Root-CA -keystore $JAVA_HOME/jre/lib/security/cacerts -file $JENKINS_HOME/certificate/SBC-Ent-Root-CA.cer -storepass changeit -noprompt || true
fi


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

cd /tmp

openssl pkcs12 -export -out jenkins.p12 -passout pass:{{ .Values.tls.keystorePwd }} -inkey tls.key \
-in tls.crt -certfile ca.crt -name {{ printf "jenkins.%s.svc.cluster.local" .Values.jenkinsNodes.service.namespace }}

keytool -importkeystore -srckeystore jenkins.p12 -srcstorepass {{ .Values.tls.keystorePwd }} \
-srcstoretype PKCS12 -srcalias {{ printf "jenkins.%s.svc.cluster.local" .Values.jenkinsNodes.service.namespace }} \
 -deststoretype JKS -destkeystore jenkins.jks -deststorepass {{ .Values.tls.keystorePwd }} \
-destalias {{ printf "jenkins.%s.svc.cluster.local" .Values.jenkinsNodes.service.namespace }}

cp /tmp/jenkins.jks /var/jenkins_home/jenkins.jks
chown jenkins:jenkins /var/jenkins_home/jenkins.jks

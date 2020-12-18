#!/bin/bash

{{- /*
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

function generate_keys () {
{{- range .Values.conf.gerrit_trigger.servers }}
ssh-keygen -N "" -t rsa -b 4096 -f /tmp/.ssh/id_rsa_{{ .name }}
{{- end }}
}

function add_keys () {
{{- range .Values.conf.gerrit_trigger.servers }}
kubectl patch secret -n ${NAMESPACE} jenkins-secret -p="{\"data\": {\"id_rsa_{{ .name }}\": \"`base64 -w 0 /tmp/.ssh/id_rsa_{{ .name }}`\"}}"
{{- end }}
}

if [ "${1}" == "create" ]; then
  generate_keys
elif [ "${1}" == "add" ]; then
  add_keys
else
  echo "Please, use \"create\" or \"add\""
  exit 1
fi

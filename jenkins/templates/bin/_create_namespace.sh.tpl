#!/bin/bash

set -ex

{{- if .Values.manifests.kubernetes_rbac_rule }}

declare -a namespaces=({{ .Values.jenkinsNodes.namespace }})
for namespace in "${namespaces[@]}"; do
  should_create_namespace=$(kubectl get namespace "$namespace" --ignore-not-found --no-headers | wc -l)

  if [ $should_create_namespace == 0 ]; then
    kubectl create namespace "$namespace"
  fi
done
{{- end -}}
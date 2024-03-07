{{/*
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

{{- define "artifactory.job_mariadb_collate" -}}
{{- $envAll := index . "envAll" -}}
{{- $serviceName := index . "serviceName" -}}
{{- $jobAnnotations := index . "jobAnnotations" -}}
{{- $jobLabels := index . "jobLabels" -}}
{{- $nodeSelector := index . "nodeSelector" | default ( dict $envAll.Values.labels.job.node_selector_key $envAll.Values.labels.job.node_selector_value ) -}}
{{- $tolerationsEnabled := index . "tolerationsEnabled" | default false -}}
{{- $configMapBin := index . "configMapBin" | default (printf "%s-%s" $serviceName "bin" ) -}}
{{- $dbToInit := index . "dbToInit" | default ( dict "adminSecret" $envAll.Values.secrets.oslo_db.admin ) -}}
{{- $backoffLimit := index . "backoffLimit" | default "1000" -}}
{{- $activeDeadlineSeconds := index . "activeDeadlineSeconds" -}}
{{- $serviceNamePretty := $serviceName | replace "_" "-" -}}
{{- $dbAdminTlsSecret := index . "dbAdminTlsSecret" | default "" -}}

{{- $serviceAccountName := printf "%s-%s" $serviceNamePretty "mariadb-collate" }}
{{ tuple $envAll "mariadb_collate" $serviceAccountName | include "helm-toolkit.snippets.kubernetes_pod_rbac_serviceaccount" }}
---
apiVersion: batch/v1
kind: Job
metadata:
  name: {{ printf "%s-%s" $serviceNamePretty "mariadb-collate" | quote }}
  labels:
{{ tuple $envAll $serviceName "mariadb-collate" | include "helm-toolkit.snippets.kubernetes_metadata_labels" | indent 4 }}
{{- if $jobLabels }}
{{ toYaml $jobLabels | indent 4 }}
{{- end }}
  annotations:
{{- if $jobAnnotations }}
{{ toYaml $jobAnnotations | indent 4 }}
{{- end }}
spec:
  backoffLimit: {{ $backoffLimit }}
{{- if $activeDeadlineSeconds }}
  activeDeadlineSeconds: {{ $activeDeadlineSeconds }}
{{- end }}
  template:
    metadata:
      labels:
{{ tuple $envAll $serviceName "mariadb-collate" | include "helm-toolkit.snippets.kubernetes_metadata_labels" | indent 8 }}
{{- if $jobLabels }}
{{ toYaml $jobLabels | indent 8 }}
{{- end }}
      annotations:
{{ tuple $envAll | include "helm-toolkit.snippets.release_uuid" | indent 8 }}
    spec:
      serviceAccountName: {{ $serviceAccountName }}
      restartPolicy: OnFailure
      {{ tuple $envAll "db_init" | include "helm-toolkit.snippets.kubernetes_image_pull_secrets" | indent 6 }}
      nodeSelector:
{{ toYaml $nodeSelector | indent 8 }}
{{- if $tolerationsEnabled }}
{{ tuple $envAll $serviceName | include "helm-toolkit.snippets.kubernetes_tolerations" | indent 6 }}
{{- end}}
      initContainers:
{{ tuple $envAll "mariadb_collate" list | include "helm-toolkit.snippets.kubernetes_entrypoint_init_container" | indent 8 }}
      containers:
{{ $dbToInitType := default "oslo" $dbToInit.inputType }}
        - name: {{ printf "%s-%s" $serviceNamePretty "mariadb-collate" | quote }}
          image: {{ $envAll.Values.images.tags.db_init }}
          imagePullPolicy: {{ $envAll.Values.images.pull_policy }}
{{ tuple $envAll $envAll.Values.pod.resources.jobs.db_init | include "helm-toolkit.snippets.kubernetes_resources" | indent 10 }}
          env:
            - name: ROOT_DB_CONNECTION
              valueFrom:
                secretKeyRef:
                  name: {{ $dbToInit.adminSecret | quote }}
                  key: DB_CONNECTION
{{- if $envAll.Values.manifests.certificates }}
            - name: MARIADB_X509
              value: "REQUIRE X509"
{{- end }}
          command:
            - /tmp/mariadb-collate.py
          volumeMounts:
            - name: pod-tmp
              mountPath: /tmp
            - name: mariadb-collate-sh
              mountPath: /tmp/mariadb-collate.py
              subPath: mariadb-collate.py
              readOnly: true
{{- if $envAll.Values.manifests.certificates }}
{{- dict "enabled" $envAll.Values.manifests.certificates "name" $dbAdminTlsSecret "path" "/etc/mysql/certs" | include "helm-toolkit.snippets.tls_volume_mount" | indent 12 }}
{{- end }}
      volumes:
        - name: pod-tmp
          emptyDir: {}
        - name: mariadb-collate-sh
          configMap:
            name: {{ $configMapBin | quote }}
            defaultMode: 0555
{{- if $envAll.Values.manifests.certificates }}
{{- dict "enabled" $envAll.Values.manifests.certificates "name" $dbAdminTlsSecret | include "helm-toolkit.snippets.tls_volume" | indent 8 }}
{{- end }}
{{- end -}}

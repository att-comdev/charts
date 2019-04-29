{{- range $plugin, $version := .Values.conf.plugins.entries }}
{{ $plugin }}:{{ $version }}
{{- end -}}

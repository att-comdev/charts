<com.orctom.jenkins.plugin.buildtimestamp.BuildTimestampWrapper_-DescriptorImpl plugin="build-timestamp@1.0.3">
{{- if .Values.conf.build_timestamp.enable }}
  <enableBuildTimestamp>{{ .Values.conf.build_timestamp.enable }}</enableBuildTimestamp>
  <timezone>{{ .Values.conf.build_timestamp.timezone }}</timezone>
  <pattern>{{ .Values.conf.build_timestamp.pattern }}</pattern>
  <extraProperties/>
{{- end }}
</com.orctom.jenkins.plugin.buildtimestamp.BuildTimestampWrapper_-DescriptorImpl>
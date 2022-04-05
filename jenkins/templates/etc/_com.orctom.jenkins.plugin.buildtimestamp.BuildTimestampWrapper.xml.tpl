<?xml version='1.1' encoding='UTF-8'?>
<com.orctom.jenkins.plugin.buildtimestamp.BuildTimestampWrapper_-DescriptorImpl plugin="build-timestamp@1.0.3">
 <enableBuildTimestamp>{{ .Values.conf.build_timestamp.enable }}</enableBuildTimestamp>
 <timezone>{{ .Values.conf.build_timestamp.timezone }}</timezone>
 <pattern>{{ .Values.conf.build_timestamp.pattern }}</pattern>
 <extraProperties/>
</com.orctom.jenkins.plugin.buildtimestamp.BuildTimestampWrapper_-DescriptorImpl>
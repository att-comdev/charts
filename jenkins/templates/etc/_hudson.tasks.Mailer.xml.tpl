<?xml version='1.1' encoding='UTF-8'?>
<hudson.tasks.Mailer_-DescriptorImpl plugin="mailer@1.21">
  <defaultSuffix>{{ .Values.conf.config.jenkins.email.suffix }}</defaultSuffix>
  <smtpHost>{{ .Values.conf.config.jenkins.email.host }}</smtpHost>
  <useSsl>false</useSsl>
  <charset>{{ .Values.conf.config.jenkins.email.charset }}</charset>
</hudson.tasks.Mailer_-DescriptorImpl>

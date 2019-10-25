<?xml version='1.1' encoding='UTF-8'?>
<hudson.plugins.emailext.ExtendedEmailPublisherDescriptor plugin="email-ext@2.62">
  <defaultSuffix>{{ .Values.conf.config.jenkins.email.suffix }}</defaultSuffix>
  <mailAccount>
    <smtpHost>{{ .Values.conf.config.jenkins.email.host }}</smtpHost>
    <useSsl>false</useSsl>
  </mailAccount>
  <addAccounts/>
  <charset>{{ .Values.conf.config.jenkins.email.charset }}</charset>
  <defaultContentType>{{ .Values.conf.config.jenkins.email.content_type }}</defaultContentType>
  <defaultSubject>$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS!</defaultSubject>
  <defaultBody>$PROJECT_NAME - Build # $BUILD_NUMBER - $BUILD_STATUS:&#xd;
&#xd;
Check console output at $BUILD_URL to view the results.</defaultBody>
  <defaultPresendScript></defaultPresendScript>
  <defaultPostsendScript></defaultPostsendScript>
  <defaultClasspath/>
  <defaultTriggerIds>
    <string>hudson.plugins.emailext.plugins.trigger.FailureTrigger</string>
  </defaultTriggerIds>
  <maxAttachmentSize>-1</maxAttachmentSize>
  <recipientList></recipientList>
  <defaultReplyTo></defaultReplyTo>
  <excludedCommitters></excludedCommitters>
  <overrideGlobalSettings>true</overrideGlobalSettings>
  <precedenceBulk>false</precedenceBulk>
  <debugMode>false</debugMode>
  <requireAdminForTemplateTesting>false</requireAdminForTemplateTesting>
  <enableWatching>false</enableWatching>
  <enableAllowUnregistered>false</enableAllowUnregistered>
</hudson.plugins.emailext.ExtendedEmailPublisherDescriptor>

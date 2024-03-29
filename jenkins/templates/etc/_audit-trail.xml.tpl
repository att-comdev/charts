<?xml version='1.1' encoding='UTF-8'?>
<hudson.plugins.audit__trail.AuditTrailPlugin plugin="audit-trail@3.4">
  <pattern>.*/(?:configSubmit|doDelete|postBuildResult|enable|disable|cancelQueue|stop|toggleLogKeep|doWipeOutWorkspace|createItem|createView|toggleOffline|cancelQuietDown|quietDown|restart|exit|safeExit|updateSubmit|createCredentials|configure|install|script)/.*</pattern>
  <logBuildCause>false</logBuildCause>
  <loggers>
    <hudson.plugins.audit__trail.LogFileAuditLogger>
      <logSeparator></logSeparator>
      <log>/var/jenkins_home/audit.log</log>
      <limit>200</limit>
      <count>2</count>
    </hudson.plugins.audit__trail.LogFileAuditLogger>
  </loggers>
</hudson.plugins.audit__trail.AuditTrailPlugin>

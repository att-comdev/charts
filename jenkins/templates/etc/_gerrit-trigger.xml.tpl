<?xml version='1.1' encoding='UTF-8'?>
<com.sonyericsson.hudson.plugins.gerrit.trigger.PluginImpl plugin="gerrit-trigger@2.30.5">
  <servers class="java.util.concurrent.CopyOnWriteArrayList">
    {{- if .Values.conf.gerrit_trigger.servers }}
    {{- range .Values.conf.gerrit_trigger.servers }}
    <com.sonyericsson.hudson.plugins.gerrit.trigger.GerritServer>
      <name>{{ .name }}</name>
      <noConnectionOnStartup>{{ .no_connection_on_startup }}</noConnectionOnStartup>
      <config class="com.sonyericsson.hudson.plugins.gerrit.trigger.config.Config">
        <gerritHostName>{{ .gerrit_hostname }}</gerritHostName>
        <gerritSshPort>{{ .gerrit_port | default "29418" }}</gerritSshPort>
        <gerritProxy>{{ .gerrit_proxy }}</gerritProxy>
        <gerritUserName>{{ .gerrit_username }}</gerritUserName>
        <gerritEMail>{{ .gerrit_email }}</gerritEMail>
        {{- $default_path := printf "id_rsa_%s" .name }}
        <gerritAuthKeyFile>/var/jenkins_home/.ssh/{{ .gerrit_authkey_path | default $default_path }}</gerritAuthKeyFile>
        <gerritAuthKeyFilePassword>{{ .gerrit_authkey_password }}</gerritAuthKeyFilePassword>
        <useRestApi>{{ .use_rest_api | default "false" }}</useRestApi>
        <restCodeReview>{{ .rest_codereview | default "false" }}</restCodeReview>
        <restVerified>{{ .rest_verified | default "false" }}</restVerified>
        <gerritVerifiedCmdBuildSuccessful>{{ .gerrit_verified_cmd_successful | default "" }}</gerritVerifiedCmdBuildSuccessful>
        <gerritVerifiedCmdBuildUnstable>{{ .gerrit_verified_cmd_unstable | default "" }}</gerritVerifiedCmdBuildUnstable>
        <gerritVerifiedCmdBuildFailed>{{ .gerrit_verified_cmd_failed | default "" }}</gerritVerifiedCmdBuildFailed>
        <gerritVerifiedCmdBuildStarted>{{ .gerrit_verified_cmd_started | default "" }}</gerritVerifiedCmdBuildStarted>
        <gerritVerifiedCmdBuildNotBuilt>{{ .gerrit_verified_cmd_not_built | default "" }}</gerritVerifiedCmdBuildNotBuilt>
        <gerritFrontEndUrl>{{ .gerrit_frontend_url }}</gerritFrontEndUrl>
        <gerritBuildStartedVerifiedValue>{{ .gerrit_build_started_verified | default "0" }}</gerritBuildStartedVerifiedValue>
        <gerritBuildSuccessfulVerifiedValue>{{ .gerrit_build_successful_verified | default "1" }}</gerritBuildSuccessfulVerifiedValue>
        <gerritBuildFailedVerifiedValue>{{ .gerrit_build_failed_verified | default "-1" }}</gerritBuildFailedVerifiedValue>
        <gerritBuildUnstableVerifiedValue>{{ .gerrit_build_unstable_verified | default "0" }}</gerritBuildUnstableVerifiedValue>
        <gerritBuildNotBuiltVerifiedValue>{{ .gerrit_build_not_built_verified | default "0" }}</gerritBuildNotBuiltVerifiedValue>
        <gerritBuildStartedCodeReviewValue>{{ .gerrit_build_started_codereview | default "0" }}</gerritBuildStartedCodeReviewValue>
        <gerritBuildSuccessfulCodeReviewValue>{{ .gerrit_build_successful_codereview | default "0" }}</gerritBuildSuccessfulCodeReviewValue>
        <gerritBuildFailedCodeReviewValue>{{ .gerrit_build_failed_codereview | default "0" }}</gerritBuildFailedCodeReviewValue>
        <gerritBuildUnstableCodeReviewValue>{{ .gerrit_build_unstable_codereview | default "-1" }}</gerritBuildUnstableCodeReviewValue>
        <gerritBuildNotBuiltCodeReviewValue>{{ .gerrit_build_not_built_codereview | default "0" }}</gerritBuildNotBuiltCodeReviewValue>
        <enableManualTrigger>{{ .enable_manual_trigger | default "true" }}</enableManualTrigger>
        <enablePluginMessages>{{ .enable_plugin_messages | default "true" }}</enablePluginMessages>
        <triggerOnAllComments>{{ .trigger_on_all_comments | default "false" }}</triggerOnAllComments>
        <buildScheduleDelay>{{ .schedule_delay | default "3" }}</buildScheduleDelay>
        <dynamicConfigRefreshInterval>{{ .dynamic_config_refresh_interval | default "30" }}</dynamicConfigRefreshInterval>
        <enableProjectAutoCompletion>{{ .project_auto_completion | default "true" }}</enableProjectAutoCompletion>
        <projectListRefreshInterval>{{ .project_list_fetch_interval | default "3600" }}</projectListRefreshInterval>
        <projectListFetchDelay>{{ .project_list_fetch_delay | default "0" }}</projectListFetchDelay>
        <categories class="linked-list">
          <com.sonyericsson.hudson.plugins.gerrit.trigger.VerdictCategory>
            <verdictValue>Code-Review</verdictValue>
            <verdictDescription>Code Review</verdictDescription>
          </com.sonyericsson.hudson.plugins.gerrit.trigger.VerdictCategory>
          <com.sonyericsson.hudson.plugins.gerrit.trigger.VerdictCategory>
            <verdictValue>Verified</verdictValue>
            <verdictDescription>Verified</verdictDescription>
          </com.sonyericsson.hudson.plugins.gerrit.trigger.VerdictCategory>
        </categories>
        <replicationConfig>
          <enableReplication>false</enableReplication>
          <slaves class="linked-list"/>
          <enableSlaveSelectionInJobs>false</enableSlaveSelectionInJobs>
        </replicationConfig>
        <watchdogTimeoutMinutes>0</watchdogTimeoutMinutes>
        <watchTimeExceptionData>
          <daysOfWeek/>
          <timesOfDay class="linked-list"/>
        </watchTimeExceptionData>
        <notificationLevel>ALL</notificationLevel>
        <buildCurrentPatchesOnly>
          <enabled>{{ .build_current_patches_only | default "false" }}</enabled>
          <abortNewPatchsets>{{ .abort_new_patch_sets | default "false" }}</abortNewPatchsets>
          <abortManualPatchsets>{{ .abort_manual_patch_sets | default "false" }}</abortManualPatchsets>
          <abortSameTopic>{{ .abort_same_topic | default "false" }}</abortSameTopic>
        </buildCurrentPatchesOnly>
      </config>
    </com.sonyericsson.hudson.plugins.gerrit.trigger.GerritServer>
  {{- end }}
  {{- end }}
  </servers>
  <pluginConfig>
    <numberOfReceivingWorkerThreads>3</numberOfReceivingWorkerThreads>
    <numberOfSendingWorkerThreads>1</numberOfSendingWorkerThreads>
    <replicationCacheExpirationInMinutes>360</replicationCacheExpirationInMinutes>
  </pluginConfig>
</com.sonyericsson.hudson.plugins.gerrit.trigger.PluginImpl>

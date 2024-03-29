<?xml version='1.1' encoding='UTF-8'?>
<org.jfrog.hudson.ArtifactoryBuilder_-DescriptorImpl plugin="artifactory@4.0.5">
  <useCredentialsPlugin>true</useCredentialsPlugin>
  <jfrogInstances>
    <org.jfrog.hudson.JFrogPlatformInstance>
      <id>artifactory</id>
      <artifactoryServer>
        <url>https://{{ .Values.conf.config.jenkins.global_env_vars.artf_web_url }}</url>
        <id>artifactory</id>
        <timeout>300</timeout>
        <bypassProxy>true</bypassProxy>
        <connectionRetry>3</connectionRetry>
        <deploymentThreads>3</deploymentThreads>
        <deployerCredentialsConfig>
          <username></username>
          <password></password>
          <credentialsId>jenkins-artifactory</credentialsId>
          <overridingCredentials>false</overridingCredentials>
          <ignoreCredentialPluginDisabled>false</ignoreCredentialPluginDisabled>
          <credentials>
            <username></username>
            <password></password>
          </credentials>
        </deployerCredentialsConfig>
        <resolverCredentialsConfig>
          <credentialsId></credentialsId>
          <overridingCredentials>false</overridingCredentials>
          <ignoreCredentialPluginDisabled>false</ignoreCredentialPluginDisabled>
        </resolverCredentialsConfig>
      </artifactoryServer>
      <deployerCredentialsConfig reference="../artifactoryServer/deployerCredentialsConfig"/>
      <resolverCredentialsConfig reference="../artifactoryServer/resolverCredentialsConfig"/>
      <bypassProxy>true</bypassProxy>
      <timeout>300</timeout>
      <connectionRetry>3</connectionRetry>
      <deploymentThreads>3</deploymentThreads>
    </org.jfrog.hudson.JFrogPlatformInstance>
  </jfrogInstances>
  <artifactoryServers>
    <org.jfrog.hudson.ArtifactoryServer>
      <url>https://{{ .Values.conf.config.jenkins.global_env_vars.artf_web_url }}</url>
      <id>artifactory</id>
      <timeout>300</timeout>
      <bypassProxy>true</bypassProxy>
      <connectionRetry>3</connectionRetry>
      <deployerCredentialsConfig reference="../../../jfrogInstances/org.jfrog.hudson.JFrogPlatformInstance/artifactoryServer/deployerCredentialsConfig"/>
      <resolverCredentialsConfig reference="../../../jfrogInstances/org.jfrog.hudson.JFrogPlatformInstance/artifactoryServer/resolverCredentialsConfig"/>
    </org.jfrog.hudson.ArtifactoryServer>
  </artifactoryServers>
  <jfrogPipelinesServer>
    <connectionRetries>3</connectionRetries>
    <bypassProxy>false</bypassProxy>
    <timeout>300</timeout>
  </jfrogPipelinesServer>
</org.jfrog.hudson.ArtifactoryBuilder_-DescriptorImpl>
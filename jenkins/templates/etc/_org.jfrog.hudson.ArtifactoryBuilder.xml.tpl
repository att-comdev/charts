<?xml version="1.0" encoding="UTF-8"?>
<org.jfrog.hudson.ArtifactoryBuilder_-DescriptorImpl plugin="artifactory@2.15.1">
  <useCredentialsPlugin>true</useCredentialsPlugin>
  <artifactoryServers>
    <org.jfrog.hudson.ArtifactoryServer>
      <url>https://{{ .Values.conf.config.jenkins.global_env_vars.artf_web_url }}</url>
      <id>artifactory</id>
      <timeout>300</timeout>
      <bypassProxy>false</bypassProxy>
      <connectionRetry>3</connectionRetry>
      <deployerCredentialsConfig>
        <credentials>
          <username/>
          <password/>
        </credentials>
        <credentialsId>jenkins-artifactory</credentialsId>
        <overridingCredentials>false</overridingCredentials>
        <ignoreCredentialPluginDisabled>false</ignoreCredentialPluginDisabled>
      </deployerCredentialsConfig>
    </org.jfrog.hudson.ArtifactoryServer>
  </artifactoryServers>
  <pushToBintrayEnabled>true</pushToBintrayEnabled>
  <buildInfoProxyEnabled>false</buildInfoProxyEnabled>
  <buildInfoProxyPort>0</buildInfoProxyPort>
  <buildInfoProxyCertPublic>/var/jenkins_home/secrets/jfrog/certs/jfrog.proxy.crt</buildInfoProxyCertPublic>
  <buildInfoProxyCertPrivate>/var/jenkins_home/secrets/jfrog/certs/jfrog.proxy.key</buildInfoProxyCertPrivate>
</org.jfrog.hudson.ArtifactoryBuilder_-DescriptorImpl>

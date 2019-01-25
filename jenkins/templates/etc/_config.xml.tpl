<?xml version="1.0" encoding="UTF-8"?>
<hudson>
  <disabledAdministrativeMonitors/>
  <version>2.89.4</version>
  <numExecutors>2</numExecutors>
  <mode>NORMAL</mode>
  <useSecurity>true</useSecurity>
  <authorizationStrategy class="hudson.security.FullControlOnceLoggedInAuthorizationStrategy">
    <denyAnonymousReadAccess>false</denyAnonymousReadAccess>
  </authorizationStrategy>
  <!-- pick a single securityRealm setup not both. If you want to choose AD based authentication
  Please uncomment appropriate section-->
  <securityRealm class="hudson.security.HudsonPrivateSecurityRealm">
    <disableSignup>false</disableSignup>
    <enableCaptcha>false</enableCaptcha>
  </securityRealm>
  <!--
  <securityRealm class="hudson.plugins.active_directory.ActiveDirectorySecurityRealm" plugin="active-directory@2.6">
    <domains>
      <hudson.plugins.active__directory.ActiveDirectoryDomain>
        <name>{{ .Values.conf.config.jenkins.active.directory }}</name>
        <bindPassword/>
      </hudson.plugins.active__directory.ActiveDirectoryDomain>
    </domains>
    <startTls>true</startTls>
    <groupLookupStrategy>AUTO</groupLookupStrategy>
    <removeIrrelevantGroups>false</removeIrrelevantGroups>
    <tlsConfiguration>TRUST_ALL_CERTIFICATES</tlsConfiguration>
  </securityRealm>
  -->
  <disableRememberMe>false</disableRememberMe>
  <projectNamingStrategy class="jenkins.model.ProjectNamingStrategy$DefaultProjectNamingStrategy"/>
  <workspaceDir>${JENKINS_HOME}/workspace/${ITEM_FULLNAME}</workspaceDir>
  <buildsDir>${ITEM_ROOTDIR}/builds</buildsDir>
  <jdks/>
  <viewsTabBar class="hudson.views.DefaultViewsTabBar"/>
  <myViewsTabBar class="hudson.views.DefaultMyViewsTabBar"/>
  <clouds/>
  <quietPeriod>5</quietPeriod>
  <scmCheckoutRetryCount>0</scmCheckoutRetryCount>
  <views>
    <hudson.model.AllView>
      <owner class="hudson" reference="../../.."/>
      <name>all</name>
      <filterExecutors>false</filterExecutors>
      <filterQueue>false</filterQueue>
      <properties class="hudson.model.View$PropertyList"/>
    </hudson.model.AllView>
  </views>
  <primaryView>all</primaryView>
  <slaveAgentPort>50000</slaveAgentPort>
  <disabledAgentProtocols>
    <string>CLI-connect</string>
    <string>CLI2-connect</string>
    <string>JNLP-connect</string>
    <string>JNLP2-connect</string>
  </disabledAgentProtocols>
  <label/>
  <crumbIssuer class="hudson.security.csrf.DefaultCrumbIssuer">
    <excludeClientIPFromCrumb>false</excludeClientIPFromCrumb>
  </crumbIssuer>
  <nodeProperties/>
  <globalNodeProperties>
    <hudson.slaves.EnvironmentVariablesNodeProperty>
      <envVars serialization="custom">
        <unserializable-parents/>
        <tree-map>
          <default>
            <comparator class="hudson.util.CaseInsensitiveComparator"/>
          </default>
          <int>16</int>
          <string>AIAB_REF</string>
          <string>master</string>
          <string>ARTF_API_URL</string>
          <string>https://$ARTF_WEB_URL/api/storage</string>
          <string>ARTF_DOCKER_URL</string>
          <string>artifacts-aic.atlantafoundry.com</string>
          <string>ARTF_SECURE_DOCKER_URL</string>
          <string>docker-aic.atlantafoundry.com</string>
          <string>ARTF_WEB_URL</string>
          <string>artifacts-aic.atlantafoundry.com/artifactory</string>
          <string>ARTIFACTORY_ENV</string>
          <string>stage/</string>
          <string>CNI_POD_CIDR</string>
          <string>10.10.11.0/24</string>
          <string>DNS_SERVER_1</string>
          <string><{{ .Values.conf.config.jenkins.dns.server1 }}/string>
          <string>DNS_SERVER_1</string>
          <string><{{ .Values.conf.config.jenkins.dns.server2 }}/string>
          <string>INTERNAL_GERRIT_URL</string>
          <string>ssh://jenkins-attcomdev@10.24.20.18:29418</string>
          <string>JENKINS_CLI</string>
          <string>/home/jenkins/integration/jenkins-cli.jar</string>
          <string>HTTP_PROXY</string>
          <string><{{ .Values.conf.config.jenkins.proxy }}/string>
          <string>HTTPS_PROXY</string>
          <string><{{ .Values.conf.config.jenkins.proxy }}/string>
          <string>NEXUS3_URL</string>
          <string>12.37.173.196:32775</string>
          <string>NO_PROXY</string>
          <string>127.0.0.1,localhost,::1,10.96.0.1,.cluster.local,172.17.0.1</string>
          <string>OSH_BR_EX_ADDR</string>
          <string>172.25.4.1/24</string>
          <string>OSH_EXT_SUBNET</string>
          <string>172.25.4.0/24</string>
          <string>PVC_BACKEND</string>
          <string>ceph</string>
          <string>QUAY_URL</string>
          <string>quay.io</string>
          <string>SILENT_MODE</string>
          <string>true</string>
          <string>SLACK_DEFAULT_CHANNEL</string>
          <string>#test-jenkins</string>
          <string>SLACK_URL</string>
          <string>https://att-comdev.slack.com/services/hooks/jenkins-ci/</string>
        </tree-map>
      </envVars>
    </hudson.slaves.EnvironmentVariablesNodeProperty>
  </globalNodeProperties>
</hudson>

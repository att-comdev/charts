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
          <int>34</int>
          <string>ARTF_API_URL</string>
          <string></string>
          <string>ARTF_DOCKER_URL</string>
          <string></string>
          <string>ARTF_IP</string>
          <string></string>
          <string>ARTF_SECURE_DOCKER_URL</string>
          <string></string>
          <string>ARTF_UBUNTU_REPO</string>
          <string></string>
          <string>ARTF_WEB_URL</string>
          <string></string>
          <string>ARTIFACTORY_ENV</string>
          <string></string>
          <string>CNI_POD_CIDR</string>
          <string></string>
          <string>CONF_PACKAGE_PATH</string>
          <string></string>
          <string>DNS_SERVER_1</string>
          <string></string>
          <string>DNS_SERVER_2</string>
          <string></string>
          <string>GERRIT_SSH</string>
          <string></string>
          <string>HTTP_PROXY</string>
          <string></string>
          <string>HTTPS_PROXY</string>
          <string></string>
          <string>INTERNAL_GERRIT_KEY</string>
          <string></string>
          <string>INTERNAL_GERRIT_PORT</string>
          <string></string>
          <string>INTERNAL_GERRIT_SSH</string>
          <string></string>
          <string>INTERNAL_GERRIT_URL</string>
          <string></string>
          <string>JENKINS_CLI</string>
          <string></string>
          <string>JENKINS_CLI_URL</string>
          <string></string>
          <string>KNOWN_HOSTS</string>
          <string></string>
          <string>MIRROR_KEY</string>
          <string></string>
          <string>MIRROR_KEY_ORIG</string>
          <string></string>
          <string>MIRROR_SLAVE_IP</string>
          <string></string>
          <string>NEXUS3_URL</string>
          <string></string>
          <string>NO_PROXY</string>
          <string></string>
          <string>OSH_BR_EX_ADDR</string>
          <string></string>
          <string>OSH_EXT_SUBNET</string>
          <string></string>
          <string>PVC_BACKEND</string>
          <string>ceph</string>
          <string>QUAY_URL</string>
          <string>quay.io</string>
          <string>SILENT_MODE</string>
          <string>true</string>
          <string>SLACK_DEFAULT_CHANNEL</string>
          <string>#test-jenkins</string>
          <string>SLACK_URL</string>
          <string></string>
          <string>SSH_DATA</string>
          <string></string>
        </tree-map>
      </envVars>
    </hudson.slaves.EnvironmentVariablesNodeProperty>
  </globalNodeProperties>
</hudson>

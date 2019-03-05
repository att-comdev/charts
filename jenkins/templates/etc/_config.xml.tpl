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
          <string>AIAB_REF</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.aiab_ref}}</string>
          <string>ARTF_API_URL</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.artf_api_url}}</string>
          <string>ARTF_DOCKER_URL</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.artf_docker_url}}</string>
          <string>ARTF_IP</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.artf_ip}}</string>
          <string>ARTF_SECURE_DOCKER_URL</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.artf_secure_docker_url}}</string>
          <string>ARTF_UBUNTU_REPO</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.artf_ubuntu_repo}}</string>
          <string>ARTF_WEB_URL</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.artf_web_url}}</string>
          <string>ARTIFACTORY_ENV</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.artifactory_env}}</string>
          <string>CNI_POD_CIDR</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.cni_pod_cidr}}</string>
          <string>CONF_PACKAGE_PATH</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.conf_package_path}}</string>
          <string>COR_DE_LDAP_GROUP</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.cor_de_ldap_group}}</string>
          <string>DNS_SERVER_1</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.dns_server_one}}</string>
          <string>DNS_SERVER_2</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.dns_server_two}}</string>
          <string>GERRIT_SSH</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.gerrit_ssh}}</string>
          <string>HTTP_PROXY</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.http_proxy}}</string>
          <string>HTTPS_PROXY</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.https_proxy}}</string>
          <string>INTERNAL_GERRIT_KEY</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.internal_gerrit_key}}</string>
          <string>INTERNAL_GERRIT_PORT</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.internal_gerrit_port}}</string>
          <string>INTERNAL_GERRIT_SSH</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.internal_gerrit_ssh}}</string>
          <string>INTERNAL_GERRIT_URL</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.internal_gerrit_url}}</string>
          <string>JENKINS_CLI</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.jenkins_cli}}</string>
          <string>JENKINS_CLI_URL</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.jenkins_cli_url}}</string>
          <string>KNOWN_HOSTS</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.known_hosts}}</string>
          <string>MIRROR_KEY</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.mirror_key}}</string>
          <string>MIRROR_KEY_ORIG</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.mirror_key_orig}}</string>
          <string>MIRROR_SLAVE_IP</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.mirror_slave_ip}}</string>
          <string>NEXUS3_URL</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.nexus_url}}</string>
          <string>NO_PROXY</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.no_proxy}}</string>
          <string>OS_AUTH_URL</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.os_auth_url}}</string>
          <string>OS_KEYSTONE_IMAGE</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.os_keystone_image}}</string>
          <string>OS_PROJECT_NAME</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.os_project_name}}</string>
          <string>OS_REGION_NAME</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.os_region_name}}</string>
          <string>OSH_BR_EX_ADDR</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.osh_br_ex_addr}}</string>
          <string>OSH_EXT_SUBNET</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.osh_ext_subnet}}</string>
          <string>PVC_BACKEND</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.pvc_backend}}</string>
          <string>QUAY_URL</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.quay_url}}</string>
          <string>SILENT_MODE</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.silent_mode}}</string>
          <string>SLACK_DEFAULT_CHANNEL</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.slack_default_channel}}</string>
          <string>SLACK_URL</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.slack_url}}</string>
          <string>SSH_DATA</string>
          <string>{{.Values.conf.config.jenkins.global_env_vars.ssh_data}}</string>
        </tree-map>
      </envVars>
    </hudson.slaves.EnvironmentVariablesNodeProperty>
  </globalNodeProperties>
</hudson>

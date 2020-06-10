<?xml version="1.0" encoding="UTF-8"?>
<hudson>
  <disabledAdministrativeMonitors/>
  <version>2.89.4</version>
  <numExecutors>2</numExecutors>
  <mode>NORMAL</mode>
  <useSecurity>true</useSecurity>
  {{- $configStrategy := .Values.conf.config.jenkins.authorizationStrategy -}}
  {{- $defaultStrategy := "hudson.security.FullControlOnceLoggedInAuthorizationStrategy" -}}
  <authorizationStrategy class={{ $configStrategy.strategy | default $defaultStrategy | quote }}>
    {{- if eq $configStrategy.strategy $defaultStrategy -}}
      <denyAnonymousReadAccess>{{ $configStrategy.denyAnonymousReadAccess }}</denyAnonymousReadAccess>
    {{- else if eq $configStrategy.strategy "hudson.security.ProjectMatrixAuthorizationStrategy" -}}
      {{- range $configStrategy.permissions }}
        <permission>{{ . | title }}</permission>
      {{- end }}
    {{- end }}
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
          <int>{{ len .Values.conf.config.jenkins.global_env_vars }}</int>
          {{- range $key, $val := .Values.conf.config.jenkins.global_env_vars }}
          <string>{{ upper $key }}</string>
          <string>{{ $val }}</string>
          {{- end }}
        </tree-map>
      </envVars>
    </hudson.slaves.EnvironmentVariablesNodeProperty>
  </globalNodeProperties>
  <clouds>
    <org.csanchez.jenkins.plugins.kubernetes.KubernetesCloud plugin="kubernetes@1.8.4">
      <name>kubernetes</name>
      <defaultsProviderTemplate></defaultsProviderTemplate>
      <templates/>
      <serverUrl>https://kubernetes.default.svc.cluster.local</serverUrl>
      <skipTlsVerify>false</skipTlsVerify>
      <addMasterProxyEnvVars>false</addMasterProxyEnvVars>
      <capOnlyOnAlivePods>false</capOnlyOnAlivePods>
      <namespace>{{.Values.jenkinsNodes.namespace}}</namespace>
      <jenkinsUrl>http://jenkins.{{.Values.jenkinsNodes.service.namespace}}.svc.cluster.local:8080</jenkinsUrl>
      <jenkinsTunnel>jenkins.{{.Values.jenkinsNodes.service.namespace}}.svc.cluster.local:50000</jenkinsTunnel>
      <containerCap>500</containerCap>
      <retentionTimeout>5</retentionTimeout>
      <connectTimeout>0</connectTimeout>
      <readTimeout>0</readTimeout>
      <maxRequestsPerHost>64</maxRequestsPerHost>
    </org.csanchez.jenkins.plugins.kubernetes.KubernetesCloud>
  </clouds>
</hudson>

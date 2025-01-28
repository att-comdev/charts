<?xml version="1.0" encoding="UTF-8"?>
<hudson>
  <disabledAdministrativeMonitors/>
  <version>2.89.4</version>
  <numExecutors>2</numExecutors>
  <mode>NORMAL</mode>
  <useSecurity>true</useSecurity>

  {{- $configStrategy := .Values.conf.config.jenkins.authorizationStrategy -}}
  {{- $defaultStrategy := "hudson.security.FullControlOnceLoggedInAuthorizationStrategy" -}}
  {{- $currentStrategy := $configStrategy.strategy | default $defaultStrategy -}}
  {{- $securityRealm := .Values.conf.config.jenkins.securityrealm -}}
  {{- $defaultSecurityRealm := "hudson.security.HudsonPrivateSecurityRealm" -}}
  {{- $currentSecurityRealm := $securityRealm.class | default $defaultSecurityRealm }}
  <authorizationStrategy class={{ $currentStrategy | quote }}>
    {{- if eq $currentStrategy $defaultStrategy -}}
      <denyAnonymousReadAccess>{{ $configStrategy.denyAnonymousReadAccess | default true}}</denyAnonymousReadAccess>
    {{- else if eq $currentStrategy "hudson.security.ProjectMatrixAuthorizationStrategy" -}}
      {{- range $configStrategy.permissions }}
    <permission>{{ . }}</permission>
      {{- end }}
    {{- end }}
  </authorizationStrategy>
  <!-- pick a single securityRealm setup not both. If you want to choose AD based authentication
  Please uncomment appropriate section-->
  {{- if eq $currentSecurityRealm $defaultSecurityRealm -}}
  <securityRealm class={{ $currentSecurityRealm | quote }}>
   <disableSignup>false</disableSignup>
   <enableCaptcha>false</enableCaptcha>
  {{- else if eq $currentSecurityRealm "hudson.security.LDAPSecurityRealm" -}}
  <securityRealm plugin="ldap@1.20" class={{ $currentSecurityRealm | quote }}>
    <disableMailAddressResolver>false</disableMailAddressResolver>
    <configurations>
      <jenkins.security.plugins.ldap.LDAPConfiguration>
        <server>{{ $securityRealm.server }}</server>
        <rootDN>{{ $securityRealm.root_dn }}</rootDN>
        <inhibitInferRootDN>false</inhibitInferRootDN>
        <userSearchBase></userSearchBase>
        {{/* Keep the default for user_search if nothing is defined in the values */}}
        {{- if not (hasKey $securityRealm "user_search") -}}
        <userSearch>sAMACCOUNTNAME={0}</userSearch>
        {{- else  -}}
        <userSearch>{{ $securityRealm.user_search }}</userSearch>
        {{- end }}
        {{- if $securityRealm.group_search }}
        <groupSearchFilter>{{ $securityRealm.group_search }}</groupSearchFilter>
        {{- end }}
        <groupMembershipStrategy class="jenkins.security.plugins.ldap.FromUserRecordLDAPGroupMembershipStrategy">
          <attributeName>memberOf</attributeName>
        </groupMembershipStrategy>
        <managerDN>{{ $securityRealm.manager_dn }}</managerDN>
        <managerPasswordSecret>{{ $securityRealm.password }}</managerPasswordSecret>
        <displayNameAttributeName>displayname</displayNameAttributeName>
        <mailAddressAttributeName>mail</mailAddressAttributeName>
        <ignoreIfUnavailable>false</ignoreIfUnavailable>
      </jenkins.security.plugins.ldap.LDAPConfiguration>
    </configurations>
    <userIdStrategy class="jenkins.model.IdStrategy$CaseInsensitive"/>
    <groupIdStrategy class="jenkins.model.IdStrategy$CaseInsensitive"/>
    <disableRolePrefixing>true</disableRolePrefixing>
  {{ else }}
  <securityRealm class={{ $currentSecurityRealm | quote }}>
  {{- end }}
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
  <label>{{ .Values.conf.node_labels.controller | default "controller" }}</label>
  <crumbIssuer class="hudson.security.csrf.DefaultCrumbIssuer">
    <excludeClientIPFromCrumb>{{ .Values.conf.config.jenkins.csrf.enable_proxy_compatibility }}</excludeClientIPFromCrumb>
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
      {{- if .Values.manifests.certificates }}
      <jenkinsUrl>https://jenkins.{{.Values.jenkinsNodes.service.namespace}}.svc.cluster.local:8443</jenkinsUrl>
      {{- else }}
      <jenkinsUrl>http://jenkins.{{.Values.jenkinsNodes.service.namespace}}.svc.cluster.local:8080</jenkinsUrl>
      {{- end }}
      <jenkinsTunnel>jenkins.{{.Values.jenkinsNodes.service.namespace}}.svc.cluster.local:50000</jenkinsTunnel>
      <containerCap>500</containerCap>
      <retentionTimeout>5</retentionTimeout>
      <connectTimeout>0</connectTimeout>
      <readTimeout>0</readTimeout>
      <maxRequestsPerHost>64</maxRequestsPerHost>
    </org.csanchez.jenkins.plugins.kubernetes.KubernetesCloud>
  </clouds>
  <markupFormatter class="hudson.markup.RawHtmlMarkupFormatter" />
</hudson>

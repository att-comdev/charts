<?xml version='1.0' encoding='UTF-8'?>
<org.jenkinsci.plugins.workflow.libs.GlobalLibraries plugin="workflow-cps-global-lib@2.9">
  <libraries>
    <org.jenkinsci.plugins.workflow.libs.LibraryConfiguration>
      <name>{{ .Values.conf.global_libraries.libraries.upstream_lib.name }}</name>
      <retriever class="org.jenkinsci.plugins.workflow.libs.SCMRetriever">
        <scm class="hudson.plugins.git.GitSCM" plugin="git@3.8.0">
          <configVersion>2</configVersion>
          <userRemoteConfigs>
            <hudson.plugins.git.UserRemoteConfig>
              <refspec>+refs/heads/*:refs/remotes/origin/* +refs/changes/*:refs/changes/*</refspec>
              <url>{{ .Values.conf.global_libraries.libraries.upstream_lib.url }}</url>
              {{- if .Values.conf.global_libraries.libraries.upstream_lib.credentials }}
                <credentialsId>{{ .Values.conf.global_libraries.libraries.upstream_lib.credentials }}</credentialsId>
              {{ end }}
            </hudson.plugins.git.UserRemoteConfig>
          </userRemoteConfigs>
          <branches>
            <hudson.plugins.git.BranchSpec>
              <name><![CDATA[${]]>library.{{ .Values.conf.global_libraries.libraries.upstream_lib.name }}.version<![CDATA[}]]></name>
            </hudson.plugins.git.BranchSpec>
          </branches>
          <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
          <submoduleCfg class="list"/>
          <extensions/>
        </scm>
      </retriever>
      <defaultVersion>master</defaultVersion>
      <implicit>true</implicit>
      <allowVersionOverride>true</allowVersionOverride>
      <includeInChangesets>true</includeInChangesets>
    </org.jenkinsci.plugins.workflow.libs.LibraryConfiguration>
    {{ if .Values.conf.global_libraries.use_internal_lib}}
      <org.jenkinsci.plugins.workflow.libs.LibraryConfiguration>
        <name>{{ .Values.conf.global_libraries.libraries.internal_lib.name }}</name>
        <retriever class="org.jenkinsci.plugins.workflow.libs.SCMRetriever">
          <scm class="hudson.plugins.git.GitSCM" plugin="git@3.8.0">
            <configVersion>2</configVersion>
            <userRemoteConfigs>
              <hudson.plugins.git.UserRemoteConfig>
                <refspec>+refs/heads/*:refs/remotes/origin/* +refs/changes/*:refs/changes/*</refspec>
                <url>{{ .Values.conf.global_libraries.libraries.internal_lib.url }}</url>
                {{- if .Values.conf.global_libraries.libraries.internal_lib.credentials }}
                  <credentialsId>{{ .Values.conf.global_libraries.libraries.internal_lib.credentials }}</credentialsId>
                {{ end }}
              </hudson.plugins.git.UserRemoteConfig>
            </userRemoteConfigs>
            <branches>
              <hudson.plugins.git.BranchSpec>
                <name><![CDATA[${]]>library.{{ .Values.conf.global_libraries.libraries.internal_lib.name }}.version<![CDATA[}]]></name>
              </hudson.plugins.git.BranchSpec>
            </branches>
            <doGenerateSubmoduleConfigurations>false</doGenerateSubmoduleConfigurations>
            <submoduleCfg class="list"/>
            <extensions/>
          </scm>
        </retriever>
        <defaultVersion>master</defaultVersion>
        <implicit>true</implicit>
        <allowVersionOverride>true</allowVersionOverride>
        <includeInChangesets>true</includeInChangesets>
      </org.jenkinsci.plugins.workflow.libs.LibraryConfiguration>
    {{ end }}
  </libraries>
</org.jenkinsci.plugins.workflow.libs.GlobalLibraries>

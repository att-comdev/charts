<?xml version='1.0' encoding='UTF-8'?>
<org.jenkinsci.plugins.workflow.libs.GlobalLibraries plugin="workflow-cps-global-lib@2.9">
  <libraries>
    <org.jenkinsci.plugins.workflow.libs.LibraryConfiguration>
      <name>{{.Values.conf.global_libraries.libraries[0].name}}</name>
      <retriever class="org.jenkinsci.plugins.workflow.libs.SCMRetriever">
        <scm class="hudson.plugins.git.GitSCM" plugin="git@3.8.0">
          <configVersion>2</configVersion>
          <userRemoteConfigs>
            <hudson.plugins.git.UserRemoteConfig>
              <refspec>refs/changes/*:refs/changes/*</refspec>
              <url>{{.Values.conf.global_libraries.libraries[0].url}}</url>
            </hudson.plugins.git.UserRemoteConfig>
          </userRemoteConfigs>
          <branches>
            <hudson.plugins.git.BranchSpec>
              <name>{{.Values.conf.global_libraries.libraries[0].branch}}</name>
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
    <org.jenkinsci.plugins.workflow.libs.LibraryConfiguration>
      <name>{{.Values.conf.global_libraries.libraries[1].name}}</name>
      <retriever class="org.jenkinsci.plugins.workflow.libs.SCMRetriever">
        <scm class="hudson.plugins.git.GitSCM" plugin="git@3.8.0">
          <configVersion>2</configVersion>
          <userRemoteConfigs>
            <hudson.plugins.git.UserRemoteConfig>
              <url>{{.Values.conf.global_libraries.libraries[1].url}}</url>
            </hudson.plugins.git.UserRemoteConfig>
          </userRemoteConfigs>
          <branches>
            <hudson.plugins.git.BranchSpec>
              <name>{{.Values.conf.global_libraries.libraries[1].branch}}</name>
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
  </libraries>
</org.jenkinsci.plugins.workflow.libs.GlobalLibraries>

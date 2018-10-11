<?xml version='1.0' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <hudson.plugins.libvirt.BeforeJobSnapshotJobProperty plugin="libvirt-slave@1.8.5"/>
    <com.sonyericsson.rebuild.RebuildSettings plugin="rebuild@1.28">
      <autoRebuild>false</autoRebuild>
      <rebuildDisabled>false</rebuildDisabled>
    </com.sonyericsson.rebuild.RebuildSettings>
    <hudson.model.ParametersDefinitionProperty>
      <parameterDefinitions>
        <hudson.model.StringParameterDefinition>
          <name>SEED_PATH</name>
          <description>Seed path. Example: cicd/SuperSeed/seed.groovy</description>
          <defaultValue></defaultValue>
        </hudson.model.StringParameterDefinition>
        <hudson.model.StringParameterDefinition>
          <name>GERRIT_REFSPEC</name>
          <description>Gerrit refspec</description>
          <defaultValue>origin/master</defaultValue>
        </hudson.model.StringParameterDefinition>
        <hudson.model.StringParameterDefinition>
          <name>GERRIT_PROJECT</name>
          <description>Project on Gerrithub</description>
          <defaultValue>att-comdev/cicd</defaultValue>
        </hudson.model.StringParameterDefinition>
      </parameterDefinitions>
    </hudson.model.ParametersDefinitionProperty>
  </properties>
  <scm class="hudson.scm.NullSCM"/>
  <assignedNode>master</assignedNode>
  <canRoam>false</canRoam>
  <disabled>false</disabled>
  <blockBuildWhenDownstreamBuilding>false</blockBuildWhenDownstreamBuilding>
  <blockBuildWhenUpstreamBuilding>false</blockBuildWhenUpstreamBuilding>
  <triggers>
    <com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.GerritTrigger plugin="gerrit-trigger@2.27.5">
      <spec></spec>
      <gerritProjects>
        <com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.data.GerritProject>
          <compareType>PLAIN</compareType>
          <pattern>att-comdev/cicd</pattern>
          <branches>
            <com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.data.Branch>
              <compareType>ANT</compareType>
              <pattern>**</pattern>
            </com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.data.Branch>
          </branches>
          <forbiddenFilePaths>
            <com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.data.FilePath>
              <compareType>PLAIN</compareType>
              <pattern>resources/**</pattern>
            </com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.data.FilePath>
            <com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.data.FilePath>
              <compareType>PLAIN</compareType>
              <pattern>vars/**</pattern>
            </com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.data.FilePath>
          </forbiddenFilePaths>
          <disableStrictForbiddenFileVerification>false</disableStrictForbiddenFileVerification>
        </com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.data.GerritProject>
        <com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.data.GerritProject>
          <compareType>PLAIN</compareType>
          <pattern>nc-cicd</pattern>
          <branches>
            <com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.data.Branch>
              <compareType>ANT</compareType>
              <pattern>**</pattern>
            </com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.data.Branch>
          </branches>
          <forbiddenFilePaths>
            <com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.data.FilePath>
              <compareType>PLAIN</compareType>
              <pattern>resources/**</pattern>
            </com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.data.FilePath>
            <com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.data.FilePath>
              <compareType>PLAIN</compareType>
              <pattern>vars/**</pattern>
            </com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.data.FilePath>
            <com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.data.FilePath>
              <compareType>PLAIN</compareType>
              <pattern>5ec-seaworthy/**</pattern>
            </com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.data.FilePath>
          </forbiddenFilePaths>
          <disableStrictForbiddenFileVerification>false</disableStrictForbiddenFileVerification>
        </com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.data.GerritProject>
      </gerritProjects>
      <dynamicGerritProjects class="empty-list"/>
      <skipVote>
        <onSuccessful>false</onSuccessful>
        <onFailed>false</onFailed>
        <onUnstable>false</onUnstable>
        <onNotBuilt>false</onNotBuilt>
      </skipVote>
      <silentMode>false</silentMode>
      <notificationLevel></notificationLevel>
      <silentStartMode>false</silentStartMode>
      <escapeQuotes>true</escapeQuotes>
      <nameAndEmailParameterMode>PLAIN</nameAndEmailParameterMode>
      <dependencyJobsNames></dependencyJobsNames>
      <commitMessageParameterMode>BASE64</commitMessageParameterMode>
      <changeSubjectParameterMode>PLAIN</changeSubjectParameterMode>
      <commentTextParameterMode>BASE64</commentTextParameterMode>
      <buildStartMessage></buildStartMessage>
      <buildFailureMessage></buildFailureMessage>
      <buildSuccessfulMessage></buildSuccessfulMessage>
      <buildUnstableMessage></buildUnstableMessage>
      <buildNotBuiltMessage></buildNotBuiltMessage>
      <buildUnsuccessfulFilepath></buildUnsuccessfulFilepath>
      <customUrl></customUrl>
      <serverName>__ANY__</serverName>
      <triggerOnEvents>
        <com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.events.PluginChangeMergedEvent/>
        <com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.events.PluginPatchsetCreatedEvent>
          <excludeDrafts>false</excludeDrafts>
          <excludeTrivialRebase>false</excludeTrivialRebase>
          <excludeNoCodeChange>false</excludeNoCodeChange>
        </com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.events.PluginPatchsetCreatedEvent>
      </triggerOnEvents>
      <dynamicTriggerConfiguration>false</dynamicTriggerConfiguration>
      <triggerConfigURL></triggerConfigURL>
      <triggerInformationAction/>
    </com.sonyericsson.hudson.plugins.gerrit.trigger.hudsontrigger.GerritTrigger>
  </triggers>
  <concurrentBuild>false</concurrentBuild>
  <builders>
    <hudson.tasks.Shell>
      <command>#!/bin/bash

set -xe

export http_proxy=$HTTP_PROXY
export https_proxy=$http_proxy

git_clone(){

    local project_name=$1
    local local_path=$2
    local refspec=$3

    # Fail-safe option in case the job is run manually
    if [ -z &quot;${GERRIT_HOST}&quot; ]; then
        local gerrit_url=&apos;https://review.gerrithub.io&apos;
    else
        if [ &quot;${GERRIT_HOST}&quot; = &quot;review.gerrithub.io&quot; ]; then
            local gerrit_url=&apos;https://review.gerrithub.io&apos;
        else
            local gerrit_url=$INTERNAL_GERRIT_SSH
        fi
    fi

    if [[ &quot;${local_path}&quot; =~ ^[\/\.]*$ ]]; then
        echo &quot;ERROR: Bad local path &apos;${local_path}&apos;&quot;
        exit 1
    fi

    if [ -z &quot;${refspec}&quot; ]; then
        echo &quot;ERROR: Empty refspec given&quot;
        exit 1
    fi

    git clone ${gerrit_url}/${project_name} ${local_path}

    pushd ${local_path}
    if [[ &quot;${refspec}&quot; =~ ^refs\/ ]]; then
        git fetch ${gerrit_url}/${project_name} ${refspec}
        git checkout FETCH_HEAD
    else
        git checkout ${refspec}
    fi
    popd
}

copy_seed(){

    if [ -f &quot;${WORKSPACE}/$1&quot; ]; then
        echo &quot;INFO: Seed file found! $1 &quot;
        mkdir -p ${WORKSPACE}/${BUILD_NUMBER}
        # &quot;${BUILD_NUMBER}/seed.groovy&quot; is a hardcoded path
        # for &apos;Process Job DSLs&apos; part of the job.
        # See cicd/SuperSeed/seed.groovy file.
        cp -a ${WORKSPACE}/$1 ${WORKSPACE}/${BUILD_NUMBER}/seed.groovy
    else
        #Fail the build if file doesn&apos;t exists:
        echo &quot;ERROR: No seed files found&quot;
        exit 1
    fi
}

find_seed(){

    if [ -z &quot;${SEED_PATH}&quot; ]; then
        if [ &quot;${GERRIT_REFSPEC}&quot; = &quot;origin/master&quot; ]; then
            echo &quot;ERROR: empty SEED_PATH parameter.&quot;
            exit 1
        fi

        echo &quot;INFO: Looking for seed.groovy file in refspec changes...&quot;
        LAST_2COMMITS=`git log -2 --reverse --pretty=format:%H`

        #Looking for added or modified seed.groovy files or Jenkinsfiles:
        MODIFIED_FILES=`git diff --name-status --no-renames ${LAST_2COMMITS} | grep -v ^D | grep &apos;seed.groovy&apos; | cut -f2`
        echo &quot;INFO: changed seed file: $MODIFIED_FILES&quot;
        if [ -z &quot;${MODIFIED_FILES}&quot; ]; then
            #No seeds?, looking for modified Jenkinsfile files:
            MODIFIED_FILES=`git diff --name-status --no-renames ${LAST_2COMMITS} | grep -v ^D | grep Jenkinsfile| cut -f2`
        echo &quot;INFO: changed Jenkinsfile: $MODIFIED_FILES&quot;
        fi

        if [ ! -z &quot;${MODIFIED_FILES}&quot; ]; then
            for file in ${MODIFIED_FILES}; do
                SEED_PATH=$(dirname ${file})/seed.groovy
                export SEED_PATH=${SEED_PATH}
            done
        fi

    else
        #if SEED_PATH param is not empty, we don&apos;t need to do anything:
        echo ${SEED_PATH}
    fi
}

######MAIN#####
git_clone ${GERRIT_PROJECT} ${WORKSPACE} ${GERRIT_REFSPEC}

find_seed
set +x

if [[ ! ${SEED_PATH} =~ ^tests/ ]]; then
    copy_seed ${SEED_PATH}
else
    echo &quot;Not copying seed, because it&apos;s tests seed.&quot;
fi

#Empty space for DSL script debug information:
echo -e &quot;=================================================\n&quot;
</command>
    </hudson.tasks.Shell>
    <javaposse.jobdsl.plugin.ExecuteDslScripts plugin="job-dsl@1.68">
      <targets>${BUILD_NUMBER}/seed.groovy</targets>
      <usingScriptText>false</usingScriptText>
      <sandbox>false</sandbox>
      <ignoreExisting>false</ignoreExisting>
      <ignoreMissingFiles>false</ignoreMissingFiles>
      <failOnMissingPlugin>false</failOnMissingPlugin>
      <unstableOnDeprecation>false</unstableOnDeprecation>
      <removedJobAction>IGNORE</removedJobAction>
      <removedViewAction>IGNORE</removedViewAction>
      <removedConfigFilesAction>IGNORE</removedConfigFilesAction>
      <lookupStrategy>JENKINS_ROOT</lookupStrategy>
    </javaposse.jobdsl.plugin.ExecuteDslScripts>
  </builders>
  <publishers/>
  <buildWrappers>
    <hudson.plugins.ws__cleanup.PreBuildCleanup plugin="ws-cleanup@0.34">
      <deleteDirs>false</deleteDirs>
      <cleanupParameter></cleanupParameter>
      <externalDelete></externalDelete>
    </hudson.plugins.ws__cleanup.PreBuildCleanup>
  </buildWrappers>
</project>

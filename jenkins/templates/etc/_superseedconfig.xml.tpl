<?xml version='1.1' encoding='UTF-8'?>
<project>
  <actions/>
  <description></description>
  <keepDependencies>false</keepDependencies>
  <properties>
    <hudson.plugins.disk__usage.DiskUsageProperty plugin="disk-usage@0.28"/>
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
          <trim>false</trim>
        </hudson.model.StringParameterDefinition>
        <hudson.model.StringParameterDefinition>
          <name>GERRIT_REFSPEC</name>
          <description>Gerrit refspec</description>
          <defaultValue>origin/master</defaultValue>
          <trim>false</trim>
        </hudson.model.StringParameterDefinition>
        <hudson.model.StringParameterDefinition>
          <name>GERRIT_PROJECT</name>
          <description>Project on Gerrithub</description>
          <defaultValue>att-comdev/cicd</defaultValue>
          <trim>false</trim>
        </hudson.model.StringParameterDefinition>
        <hudson.model.StringParameterDefinition>
          <name>RELEASE_FILE_PATH</name>
          <description>File that points to a list of seed.groovy to execute for a Cloudharbor site</description>
          <defaultValue></defaultValue>
          <trim>false</trim>
        </hudson.model.StringParameterDefinition>
        <hudson.model.StringParameterDefinition>
          <name>GERRIT_BRANCH</name>
          <description></description>
          <defaultValue>master</defaultValue>
          <trim>false</trim>
        </hudson.model.StringParameterDefinition>
        <hudson.model.StringParameterDefinition>
          <name>GERRIT_HOST</name>
          <description></description>
          <defaultValue>review.gerrithub.io</defaultValue>
          <trim>false</trim>
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

    if [[ &quot;${GERRIT_HOST}&quot; =~ review ]]; then
        local gerrit_url=&apos;https://review.gerrithub.io&apos;
    else
        local gerrit_url=$INTERNAL_GERRIT_SSH
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

get_seed(){
    # recursive search of seed.groovy for a Jenkinsfile
    # Lookup in same or higher level directories

    SEED=&apos;&apos;
    dir_path=$1
    set +e
    FILE=`ls ${WORKSPACE}/${dir_path}/ | egrep &quot;*seed*.groovy&quot;`
    if [ $FILE ]; then
       # found seed for the Jenkinsfile
       SEED=&quot;${dir_path}/$FILE&quot;
        return
    fi
    up_dir=$(dirname ${dir_path})
    if [ ${up_dir} == &quot;.&quot; ]; then
        # reached top level dir
        echo &quot;ERROR: seed file not found in ${dir_path}/...&quot;
        exit 1
    fi

    # check seed in one level higher directory
    get_seed ${up_dir}
}

create_seed_list(){
    # Create a list of seeds from the release file
    # which is located under the src/ direcotry

    local release_file=$1

    if [ ! -f ${release_file} ]; then
        echo &quot;ERROR: Release file not found!&quot;
    exit 1
    fi
    while read -r line || [[ -n &quot;$line&quot; ]]; do
        line+=&quot;,&quot;
        release_list=$release_list$line
        echo &quot;INFO: Text read from release file: $line&quot;
    done &lt; ${release_file}

    export RELEASE_LIST=$release_list
    echo &quot;INFO: RELEASE_LIST is [${RELEASE_LIST}]&quot;

}

copy_seed(){
    # Split comma separated seed list
    # copy all seed.groovy files with prefixed dir name
    # param - comma separated relative paths of seed.groovy

    # &quot;${BUILD_NUMBER}/seed_&lt;seeddirname&gt;.groovy&quot; is a hardcoded path
    # for &apos;Process Job DSLs&apos; part of the job.
    # See cicd/SuperSeed/seed.groovy file.

    mkdir -p ${WORKSPACE}/${BUILD_NUMBER}
    seed_list=$(echo $1 | tr &quot;,&quot; &quot;\n&quot;)

    for seed in $seed_list; do
        seed_file=&quot;${WORKSPACE}/${seed}&quot;
        if [ -f ${seed_file} ]; then

            # copy dependency file(s)
            grep -E &quot;evaluate\(.+\.groovy.?\)&quot; &quot;${seed_file}&quot; | while read -r match ; do
                eval dep_file_target_loc=$(echo &quot;$match&quot; | cut -d &apos;&quot;&apos; -f2)
                dep_file_name=$(basename &quot;$dep_file_target_loc&quot;)
                dep_file_loc=$(find ${WORKSPACE} -name &quot;$dep_file_name&quot;)
                cp -a $dep_file_loc $dep_file_target_loc
            done

            random_string=$(head /dev/urandom | tr -dc A-Za-z | head -c 6)
            # suffix directory name to seed to identify multiple seeds
            # convert &apos;-&apos; to &apos;_&apos; to avoid dsl script name error
            seed_dir=$(dirname ${seed} | awk -F &apos;/&apos; &apos;{print $NF}&apos; | tr &apos;-&apos; &apos;_&apos;)
            cp -a ${seed_file} ${WORKSPACE}/${BUILD_NUMBER}/seed_${random_string}_${seed_dir}.groovy
        else
            # Fail the build if file doesn&apos;t exists:
            echo &quot;ERROR: ${seed_file} not found&quot;
            exit 1
        fi
    done
}

find_seed(){

    if [ -z &quot;${SEED_PATH}&quot; ]; then
        if [ &quot;${GERRIT_REFSPEC}&quot; = &quot;origin/master&quot; ]; then
            echo &quot;ERROR: empty SEED_PATH parameter.&quot;
            exit 1
        fi

        echo &quot;INFO: Looking for seed.groovy file(s) in refspec changes...&quot;
        LAST_2COMMITS=`git log -2 --reverse --pretty=format:%H`

        # Looking for added or modified seed.groovy files or Jenkinsfiles or only superseed.sh:
        MODIFIED_FILES=`git diff --name-status --no-renames ${LAST_2COMMITS} | grep -v ^D | egrep &quot;*seed*.groovy|*Jenkinsfile*|superseed.sh&quot; | cut -f2`
        echo &quot;INFO: changed seed or Jenkinsfile(s): $MODIFIED_FILES&quot;
        echo &quot;INFO: Building the SEED_PATH for all seed.groovy files...&quot;
        if [ ! -z &quot;${MODIFIED_FILES}&quot; ]; then
            for file in ${MODIFIED_FILES}; do

                # lookup seed.groovy
                get_seed &quot;$(dirname ${file})&quot;

                if [[ -z &quot;${SEED_PATH}&quot; ]]; then
                    # set first time
                    SEED_PATH=${SEED}
                elif [[ ! ${SEED_PATH} =~ ${SEED} ]]; then
                    # if seed not already present, append to it
                    SEED_PATH=${SEED_PATH},${SEED}
                fi
            done
        else
            # Fail the build as no seed or jenkinsfile found
            echo &quot;ERROR: No seed files found&quot;
            exit 1
        fi
    fi

    export SEED_PATH=$SEED_PATH
    echo &quot;INFO: SEED_PATH is [${SEED_PATH}]&quot;
}


check_sandbox_parameter(){

    #checks if the Sandbox value is either true or an empty  value and fails the job
    # Looking for added or modified seed.groovy files or Jenkinsfiles
    LAST_2COMMITS=$(git log -2 --reverse --pretty=format:%H)
    MODIFIED_FILES_SEEDGROOVY=$(git diff --name-status --no-renames ${LAST_2COMMITS} | grep -v ^D | egrep &quot;*seed*.groovy&quot; | cut -f2)
    for file in ${MODIFIED_FILES_SEEDGROOVY[@]}; do
        SANDBOX_CHECK=$(awk &apos;/sandbox *\( *\)|sandbox *\( *true[^false]/&apos; $file)
        if [ ! -z &quot;${SANDBOX_CHECK}&quot; ]; then
            echo &quot;ERROR: Set sandbox(false) in the following file: $file&quot;
            exit 1
        fi
    done

}

lint_jenkins_files(){
    # Looking for added or modified seed.groovy files or Jenkinsfiles
    LAST_2COMMITS=$(git log -2 --reverse --pretty=format:%H)
    MODIFIED_FILES=$(git diff --name-status --no-renames ${LAST_2COMMITS} | grep -v ^D | egrep &quot;*seed*.groovy|*Jenkinsfile*&quot; | cut -f2)

    echo &quot;NOTICE: Jenkins linter does not check for all errors and can&apos;t be 100% trusted&quot;
    for file in ${MODIFIED_FILES}; do
        # JENKINS-42730: declarative-linter don&apos;t work with shared library
        # Iterate all files and skip linter checks if file contains
        # class imports from global share libraries
        egrep &quot;import.*att.*&quot; ${file} &amp;&amp; \
            echo &quot;INFO:[JENKINS-42730] Skipping linter for file &quot;&quot;${file}&quot;&quot;...&quot; &amp;&amp; \
            continue
        echo &quot;INFO: linting file &quot;&quot;${file}&quot;&quot;...&quot;
        opts=&quot;-s ${JENKINS_CLI_URL} -auth ${JENKINS_USER}:${JENKINS_TOKEN}&quot;
        cat &quot;${file}&quot; | java -jar ${JENKINS_CLI} ${opts} declarative-linter
    done
}

lint_whitespaces(){
    # find whitespaces at the end of lines in all files (except hidden, e.g. .git/)
    WHITESPACEDFILES=$(find . -not -path &quot;*/\.*&quot; -type f -exec egrep -l &quot; +$&quot; {} \;)
    if [[ -z &quot;${WHITESPACEDFILES}&quot; ]]; then
        echo &quot;No whitespaces at the end of lines.&quot;
    else
        echo -e &quot;Remove whitespaces at the end of lines in the following files:\n${WHITESPACEDFILES}&quot; &gt;&amp;2
        exit 1
    fi
}

######MAIN#####
git_clone ${GERRIT_PROJECT} ${WORKSPACE} ${GERRIT_REFSPEC}
if [[ ! -z ${RELEASE_FILE_PATH} ]]; then
    if [[ ! -z ${SEED_PATH} ]]; then
       echo &quot;ERROR: Please choose one out of RELEASE_FILE_PATH, SEED_PATH&quot;
       exit 1
    fi
    create_seed_list ${RELEASE_FILE_PATH}
    copy_seed ${RELEASE_LIST}
else
    lint_whitespaces
    lint_jenkins_files
    if [[ &quot;${GERRIT_HOST}&quot; = review ]]; then
        check_sandbox_parameter
    fi

    # Skip applying the seed files for patchsets
    if [[ ${GERRIT_EVENT_TYPE} == &quot;patchset-created&quot; ]]; then
        echo &quot;INFO: Not applying seeds for patchsets, Seeds are applied only after merge&quot;
        exit 0
    fi

    find_seed

    if [[ ! ${SEED_PATH} =~ ^tests/ ]]; then
        copy_seed ${SEED_PATH}
    else
        echo &quot;Not copying seed(s), because it is in tests/ directory&quot;
    fi
fi
# Empty space for DSL script debug information:
echo -e &quot;=================================================\n&quot;</command>
    </hudson.tasks.Shell>
    <javaposse.jobdsl.plugin.ExecuteDslScripts plugin="job-dsl@1.68">
      <targets>${BUILD_NUMBER}/**/seed*.groovy</targets>
      <usingScriptText>false</usingScriptText>
      <sandbox>false</sandbox>
      <ignoreExisting>false</ignoreExisting>
      <ignoreMissingFiles>true</ignoreMissingFiles>
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
    <org.jenkinsci.plugins.credentialsbinding.impl.SecretBuildWrapper plugin="credentials-binding@1.20">
      <bindings class="empty-list"/>
    </org.jenkinsci.plugins.credentialsbinding.impl.SecretBuildWrapper>
    <com.cloudbees.jenkins.plugins.sshagent.SSHAgentBuildWrapper plugin="ssh-agent@1.15">
      <credentialIds>
        <string>{{ .Values.conf.config.jenkins.global_env_vars.internal_gerrit_key }}</string>
      </credentialIds>
      <ignoreMissing>false</ignoreMissing>
    </com.cloudbees.jenkins.plugins.sshagent.SSHAgentBuildWrapper>
  </buildWrappers>
</project>
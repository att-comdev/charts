import javaposse.jobdsl.dsl.*
import javaposse.jobdsl.plugin.*
import jenkins.model.*
import hudson.model.*
import hudson.slaves.EnvironmentVariablesNodeProperty

def repo = 'https://review.gerrithub.io/att-comdev/cicd'
def ref = 'refs/changes/06/550806/8'
def seedFile = 'cicd/SuperSeed/seed.groovy'
def jobsList = 'cicddepot/aqua_cicd_depot_release' //'{{ .Values.conf.config.jenkins.job_list_file }}'

//only for the initial deployment (if there are no jobs in jenkins)
if (Jenkins.instance.getAllItems(Job.class).size() == 0) {
    //clone cicd repo
    def cloneCmd = ["bash", "-c", "(git clone $repo cicd && cd cicd && git fetch origin $ref && git checkout FETCH_HEAD) 2>&1"]
    def cloneProc = cloneCmd.execute(["GIT_SSH_COMMAND=ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"], new File('/tmp'))
    println cloneProc.text

    //create seed job
    JenkinsJobManagement jm = new JenkinsJobManagement(System.out, [:], new File('/tmp/cicd'));
    DslScriptLoader dslScriptLoader = new DslScriptLoader(jm)
    def jobName = dslScriptLoader.runScript(new File('/tmp/cicd', seedFile).text).jobs.first().jobName

    //seed jenkins jobs from a release list
    if (jobsList) {
        println "Seeding jobs from '${jobsList}'"
        def createdJob = null
        jobName.split('/').each { createdJob=(createdJob == null ? Jenkins.instance.getJob(it) : createdJob.getJob(it)) }

        def envVars = Jenkins.instance.getGlobalNodeProperties().get(EnvironmentVariablesNodeProperty).getEnvVars()

        def params = [
            new StringParameterValue('RELEASE_FILE_PATH', jobsList),
            new StringParameterValue('GERRIT_REFSPEC', 'main'),
            new StringParameterValue('GERRIT_HOST', envVars['INTERNAL_GERRIT_URL']),
            new StringParameterValue('GERRIT_PROJECT', 'nc-cicd'),
        ]
        def future = job.scheduleBuild(0, new ParametersAction(params))
    }
}

// remove this script and tmp files after the initial deployment
new File('/tmp/cicd').deleteDir()
new File(getClass().protectionDomain.codeSource.location.path).delete()
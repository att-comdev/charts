import javaposse.jobdsl.dsl.*
import javaposse.jobdsl.plugin.*
import jenkins.model.*
import hudson.model.*
import hudson.slaves.EnvironmentVariablesNodeProperty
import jenkins.model.GlobalConfiguration

// for SuperSeed job
def repo = 'https://review.gerrithub.io/att-comdev/cicd'
def ref = 'refs/changes/06/550806/10'
def seedFile = 'cicd/SuperSeed/seed.groovy'
def jenkinsFile = 'cicd/SuperSeed/superseed.Jenkinsfile'

// for seeding other jobs
def jobsList = 'cicddepot/aqua_cicd_depot_release' //'{{ .Values.conf.config.jenkins.job_list_file }}'

//only for the initial deployment (if there are no jobs in jenkins)
if(Jenkins.instance.getAllItems(hudson.model.Job).size() == 0) {
    //clone cicd repo
    def cloneProc = ["bash", "-c", "(GIT_SSH_COMMAND='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no' && "
        + "git clone $repo /tmp/cicd && cd /tmp/cicd && git fetch origin $ref && git checkout FETCH_HEAD) 2>&1"].execute()
    println(cloneProc.text)

    //create seed job
    JenkinsJobManagement jm = new JenkinsJobManagement(System.out, [:], new File('/tmp/cicd'));
    DslScriptLoader dslScriptLoader = new DslScriptLoader(jm)
    def jobName = dslScriptLoader.runScript(new File('/tmp/cicd', seedFile).text).jobs.last().jobName

    // approve its groovy code
    def scriptApproval = org.jenkinsci.plugins.scriptsecurity.scripts.ScriptApproval.get()
    scriptApproval.approveScript(scriptApproval.hash(new File('/tmp/cicd', jenkinsFile).text, 'groovy'))

    //seed jenkins jobs from a release list
    if (jobsList) {
        println "Seeding jobs from '$jobsList' using job '$jobName'"
        def createdJob = null
        jobName.split('/').each { createdJob=(createdJob == null ? Jenkins.instance.getJob(it) : createdJob.getJob(it)) }

        def envVars = Jenkins.instance.getGlobalNodeProperties().get(EnvironmentVariablesNodeProperty).getEnvVars()

        def params = [
            new StringParameterValue('SEED_PATH', ''),
            new StringParameterValue('RELEASE_FILE_PATH', jobsList),
            new StringParameterValue('GERRIT_REFSPEC', 'main'),
            new StringParameterValue('GERRIT_HOST', envVars['INTERNAL_GERRIT_URL']),
            new StringParameterValue('GERRIT_PROJECT', 'nc-cicd'),
        ]

        // temporarely disable script security for job dsl scripts
        GlobalConfiguration.all().get(GlobalJobDslSecurityConfiguration.class).useScriptSecurity = false

        // schedule seeding and wait for the job to complete
        createdJob.scheduleBuild2(0, new ParametersAction(params)).get()

        // enable script security
        GlobalConfiguration.all().get(GlobalJobDslSecurityConfiguration.class).useScriptSecurity = true
    }

    // remove this script and tmp files after the initial deployment
    new File('/tmp/cicd').deleteDir()
}
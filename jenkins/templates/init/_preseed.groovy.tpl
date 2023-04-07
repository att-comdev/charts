import javaposse.jobdsl.dsl.*
import javaposse.jobdsl.plugin.*
import jenkins.model.*
import hudson.model.*
import hudson.slaves.EnvironmentVariablesNodeProperty
import jenkins.model.GlobalConfiguration
import java.util.concurrent.TimeUnit

// for the SuperSeed job
def repo = 'https://review.gerrithub.io/att-comdev/cicd'
def ref = 'master'
def seedFile = 'cicd/SuperSeed/seed.groovy'
def jenkinsFile = 'cicd/SuperSeed/superseed.Jenkinsfile'

// for seeding other jobs
def jobsList = '{{ .Values.conf.config.jenkins.job_list_file }}'

def currentSuperSeedJob = Jenkins.instance.getJob('cicd')?.getJob('SuperSeed')
def superSeedJobIsOld = currentSuperSeedJob.getClass() == hudson.model.FreeStyleProject
def jenkinsIsEmpty = Jenkins.instance.getAllItems(hudson.model.Job).size() == 0

//script should run only for the initial deployment (if there are no jobs in jenkins)
if(jenkinsIsEmpty || superSeedJobIsOld) {
    //clone cicd repo
    def cloneProc = ["bash", "-c", "(GIT_SSH_COMMAND='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no' && "
        + "git clone $repo /tmp/cicd && cd /tmp/cicd && git fetch origin $ref && git checkout FETCH_HEAD) 2>&1"].execute()
    println(cloneProc.text)

    //remove old freestyle superseed job (otherwise the new one won't be created because of job type mismatch)
    if(superSeedJobIsOld) {
        currentSuperSeedJob.delete()
    }

    // preapprove seed job script
    def scriptApproval = org.jenkinsci.plugins.scriptsecurity.scripts.ScriptApproval.get()
    def scriptText = new File('/tmp/cicd', jenkinsFile).text.replace("\r\n", "\n") // match unix line endings used by jenkins
    scriptApproval.preapprove(scriptText, org.jenkinsci.plugins.scriptsecurity.scripts.languages.GroovyLanguage.get())
    scriptApproval.save()

    //create seed job
    JenkinsJobManagement jm = new JenkinsJobManagement(System.out, [:], new File('/tmp/cicd'));
    DslScriptLoader dslScriptLoader = new DslScriptLoader(jm)
    def jobName = dslScriptLoader.runScript(new File('/tmp/cicd', seedFile).text).jobs.last().jobName

    //seed jenkins jobs from a release list (only for new deployment)
    if (jobsList && jenkinsIsEmpty) {
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

        try {
            // temporarily disable script security for job dsl scripts
            GlobalConfiguration.all().get(GlobalJobDslSecurityConfiguration.class).useScriptSecurity = false

            // seed jobs (15 min timeout)
            createdJob.scheduleBuild2(0, new ParametersAction(params)).get(15, TimeUnit.MINUTES)
        } finally {
            // enable script security even if error occured
            GlobalConfiguration.all().get(GlobalJobDslSecurityConfiguration.class).useScriptSecurity = true
        }
    }

    // remove tmp files after the initial deployment
    new File('/tmp/cicd').deleteDir()
}
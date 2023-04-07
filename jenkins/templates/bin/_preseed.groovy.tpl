import javaposse.jobdsl.dsl.*
import  javaposse.jobdsl.plugin.*

def cloneProc = ["bash", "-c", "git clone ${args[0]} cicd && cd cicd && git fetch origin ${args[1]} && git checkout FETCH_HEAD"].execute(["GIT_SSH_COMMAND=ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"], new File('/tmp'))
def errorBuf = new StringBuffer()
cloneProc.consumeProcessErrorStream(errorBuf)
println cloneProc.text
println errorBuf.toString()

JenkinsJobManagement jm = new JenkinsJobManagement(System.out, [:], new File('/tmp/cicd'));
DslScriptLoader dslScriptLoader = new DslScriptLoader(jm)
args[2..-1].each {
    dslScriptLoader.runScript(new File('/tmp/cicd', it).text)
}
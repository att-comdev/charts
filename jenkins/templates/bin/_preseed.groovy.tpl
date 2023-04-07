import javaposse.jobdsl.dsl.*
import  javaposse.jobdsl.plugin.*

JenkinsJobManagement jm = new JenkinsJobManagement(System.out, [:], new File('.'));
DslScriptLoader dslScriptLoader = new DslScriptLoader(jm)
dslScriptLoader.runScript(new File(args[0]).text)
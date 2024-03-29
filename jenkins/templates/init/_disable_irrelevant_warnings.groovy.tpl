import jenkins.*
import jenkins.model.*
import hudson.*
import hudson.model.*

def warnings = Jenkins.instance.getActiveAdministrativeMonitors()

def warningsToDisable = [
  	warnings.find { it.id == "jenkins.diagnostics.ControllerExecutorsAgents" },
    warnings.find { it.id == "jenkins.security.ResourceDomainRecommendation" },
    warnings.find { it.id == "jenkins.model.BuiltInNodeMigration" }
].findAll { it!= null }

warningsToDisable.each {
  it.disable(true)
  println "disabled warning message: ${it.id}"
}

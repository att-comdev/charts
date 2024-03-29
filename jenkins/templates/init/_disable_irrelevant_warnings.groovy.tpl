import jenkins.*
import jenkins.model.*
import hudson.*
import hudson.model.*

def warnings = Jenkins.instance.getActiveAdministrativeMonitors()

def warningsToDisable = [
    // Disable warning that suggests disabling agent on the jenkins server itself
    warnings.find { it.id == "jenkins.diagnostics.ControllerExecutorsAgents" },

    // Disable warning that recommends using separate domain for static content
    warnings.find { it.id == "jenkins.security.ResourceDomainRecommendation" },

    // Disable warning about built-in node label change
    warnings.find { it.id == "jenkins.model.BuiltInNodeMigration" },

    // Sometimes the message stays after root url is set. It is not correct and needs to be dismissed.
    warnings.find { it.id == "jenkins.diagnostics.RootUrlNotSetMonitor" && Jenkins.instance.getRootUrl() }
].findAll { it!= null }

warningsToDisable.each {
  it.disable(true)
  println "disabled warning message: ${it.id}"
}

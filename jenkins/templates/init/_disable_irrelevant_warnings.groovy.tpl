def warnings = Jenkins.instance.getActiveAdministrativeMonitors()

def warningsToDisable = [
  	warnings.find { it.id == "jenkins.diagnostics.ControllerExecutorsAgents" },
    warnings.find { it.id == "jenkins.security.ResourceDomainRecommendation" }
].findAll { it!= null }

warningsToDisable.each {
  it.disable(true)
  println "disabled warning message: ${it.id}"
}

def jenkins = Jenkins.getInstance()
jenkins.proxy = null
jenkins.save()
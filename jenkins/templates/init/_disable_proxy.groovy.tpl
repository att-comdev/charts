import jenkins.*
import jenkins.model.*
import hudson.*
import hudson.model.*

def jenkins = Jenkins.getInstance()
jenkins.proxy = null
jenkins.save()

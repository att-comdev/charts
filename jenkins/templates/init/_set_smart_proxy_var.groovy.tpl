{{- if .Values.conf.smart_proxy.enable -}}
//set smart proxy jenkins variable
import jenkins.model.*
def varName = "UNIVERSAL_PROXY"
def varValue = "http://smart-proxy.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.conf.smart_proxy.port }}"
def instance = Jenkins.instance
def globalNodeProps = instance.getGlobalNodeProperties()
def envVarsNodePropertyList = globalNodeProps.getAll(hudson.slaves.EnvironmentVariablesNodeProperty.class)
def envVars
if (envVarsNodePropertyList.isEmpty()) {
    def newEnvVarsNodeProperty = new hudson.slaves.EnvironmentVariablesNodeProperty()
    globalNodeProps.add(newEnvVarsNodeProperty)
    envVars = newEnvVarsNodeProperty.getEnvVars()
} else {
    envVars = envVarsNodePropertyList.get(0).getEnvVars()
}
envVars.put(varName, varValue)
instance.save()
{{- end -}}
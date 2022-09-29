<?xml version='1.1' encoding='UTF-8'?>
<org.jenkinsci.plugins.gitclient.GitHostKeyVerificationConfiguration plugin="git-client@3.11.2">
{{- if eq .Values.conf.git_client_config.strategy "KnownHostsFileVerificationStrategy" }}
  <sshHostKeyVerificationStrategy class="org.jenkinsci.plugins.gitclient.verifier.KnownHostsFileVerificationStrategy">
{{- else if eq .Values.conf.git_client_config.strategy "AcceptFirstConnectionStrategy" }}
  <sshHostKeyVerificationStrategy class="org.jenkinsci.plugins.gitclient.verifier.AcceptFirstConnectionStrategy">
{{- else if eq .Values.conf.git_client_config.strategy "NoHostKeyVerificationStrategy" }}
  <sshHostKeyVerificationStrategy class="org.jenkinsci.plugins.gitclient.verifier.NoHostKeyVerificationStrategy">
{{- else if eq .Values.conf.git_client_config.strategy "ManuallyProvidedKeyVerificationStrategy" }}
  <sshHostKeyVerificationStrategy class="org.jenkinsci.plugins.gitclient.verifier.ManuallyProvidedKeyVerificationStrategy">
  {{- if .Values.conf.git_client_config.manualKeysFromKnownHostsSystemParam }}
    <approvedHostKeys>{{ splitList "\\n" .Values.conf.config.jenkins.global_env_vars.known_hosts | join "\n" }}</approvedHostKeys>
  {{- else if .Values.conf.git_client_config.approvedHostKeys }}
    <approvedHostKeys>{{-  .Values.conf.git_client_config.approvedHostKeys -}}</approvedHostKeys>
  {{- else -}}
    {{ fail "Provide the keys in .Values.conf.git_client_config.approvedHostKeys or enable .Values.conf.git_client_config.manualKeysFromKnownHostsSystemParam" }}
  {{- end -}}
{{- else -}}
  {{ fail "The value of .Values.conf.git_client_config.strategy is not in the allowed list" }}
{{- end }}
  </sshHostKeyVerificationStrategy>
</org.jenkinsci.plugins.gitclient.GitHostKeyVerificationConfiguration>

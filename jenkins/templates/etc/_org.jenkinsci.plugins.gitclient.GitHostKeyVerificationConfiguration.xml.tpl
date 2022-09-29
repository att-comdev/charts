<?xml version='1.1' encoding='UTF-8'?>
<org.jenkinsci.plugins.gitclient.GitHostKeyVerificationConfiguration plugin="git-client@3.11.2">
  <sshHostKeyVerificationStrategy class="org.jenkinsci.plugins.gitclient.verifier.ManuallyProvidedKeyVerificationStrategy">
    <approvedHostKeys>{{ splitList "\\n" .Values.conf.config.jenkins.global_env_vars.known_hosts | join "\n" }}</approvedHostKeys>
  </sshHostKeyVerificationStrategy>
</org.jenkinsci.plugins.gitclient.GitHostKeyVerificationConfiguration>
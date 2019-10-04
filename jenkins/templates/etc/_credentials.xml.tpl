<?xml version="1.0" encoding="UTF-8"?>
<com.cloudbees.plugins.credentials.SystemCredentialsProvider plugin="credentials@2.1.16">
  <domainCredentialsMap class="hudson.util.CopyOnWriteMap$Hash">
    <entry>
      <com.cloudbees.plugins.credentials.domains.Domain>
        <specifications/>
      </com.cloudbees.plugins.credentials.domains.Domain>
      <java.util.concurrent.CopyOnWriteArrayList>
      {{- range .Values.conf.credentials.passphrases.entries }}
        <com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>
          <scope>{{ .scope }}</scope>
          <id>{{ .id }}</id>
          <description>{{ .description }}</description>
          <username>{{ .username }}</username>
          <password>{{ .password }}</password>
        </com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>
      {{ end -}}
      {{- range .Values.conf.credentials.keys.entries }}
        <com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey plugin="ssh-credentials@1.13">
          <scope>{{ .scope }}</scope>
          <id>{{ .id }}</id>
          <description>{{ .description }}</description>
          <username>{{ .username }}</username>
          <passphrase>{{ .passphrase }}</passphrase>
          <privateKeySource class="com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey$UsersPrivateKeySource"/>
        </com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey>
      {{ end -}}
      </java.util.concurrent.CopyOnWriteArrayList>
    </entry>
  </domainCredentialsMap>
</com.cloudbees.plugins.credentials.SystemCredentialsProvider>

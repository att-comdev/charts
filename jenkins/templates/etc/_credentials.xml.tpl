<?xml version="1.0" encoding="UTF-8"?>
<com.cloudbees.plugins.credentials.SystemCredentialsProvider plugin="credentials@2.1.16">
  <domainCredentialsMap class="hudson.util.CopyOnWriteMap$Hash">
    <entry>
      <com.cloudbees.plugins.credentials.domains.Domain>
        <specifications/>
      </com.cloudbees.plugins.credentials.domains.Domain>
      <java.util.concurrent.CopyOnWriteArrayList>
      {{- range $id, $cred := .Values.conf.credentials.passphrases.entries }}
        <com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>
          <scope>{{ index $cred "scope" }}</scope>
          <id>{{ $id }}</id>
          <description>{{ index $cred "description" }}</description>
          <username>{{ index $cred "username" }}</username>
          <password>{{ index $cred "password" }}</password>
        </com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>
      {{ end -}}
      {{- range $id, $cred := .Values.conf.credentials.keys.entries }}
        <com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey plugin="ssh-credentials@1.13">
          <scope>{{ index $cred "scope" }}</scope>
          <id>{{ $id }}</id>
          <description>{{ index $cred "description" }}</description>
          <username>{{ index $cred "username" }}</username>
          <passphrase>{{ index $cred "passphrase" }}</passphrase>
            {{- if index $cred "privateKey" }}
              <privateKeySource class="com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey$DirectEntryPrivateKeySource">
                <privateKey>{{ index $cred "privateKey" }}</privateKey>
              </privateKeySource>
            {{ - else }}
              <privateKeySource class="com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey$UsersPrivateKeySource"/>
            {{ end }}
        </com.cloudbees.jenkins.plugins.sshcredentials.impl.BasicSSHUserPrivateKey>
      {{ end -}}
      </java.util.concurrent.CopyOnWriteArrayList>
    </entry>
  </domainCredentialsMap>
</com.cloudbees.plugins.credentials.SystemCredentialsProvider>

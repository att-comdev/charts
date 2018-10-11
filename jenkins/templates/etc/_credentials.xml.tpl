<?xml version="1.0" encoding="UTF-8"?>
<com.cloudbees.plugins.credentials.SystemCredentialsProvider plugin="credentials@2.1.16">
  <domainCredentialsMap class="hudson.util.CopyOnWriteMap$Hash">
    <entry>
      <com.cloudbees.plugins.credentials.domains.Domain>
        <specifications/>
      </com.cloudbees.plugins.credentials.domains.Domain>
      <java.util.concurrent.CopyOnWriteArrayList>
        <com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>
          <scope>GLOBAL</scope>
          <id>jenkins-foundry-artifactory</id>
          <description>This user is used only by Jenkins to push artifacts to artifactory</description>
          <username>jenkins</username>
          <password>{{ .Values.conf.config.jenkins.credentials.artifactory }}</password>
        </com.cloudbees.plugins.credentials.impl.UsernamePasswordCredentialsImpl>
      </java.util.concurrent.CopyOnWriteArrayList>
    </entry>
  </domainCredentialsMap>
</com.cloudbees.plugins.credentials.SystemCredentialsProvider>

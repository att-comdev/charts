<?xml version="1.0" encoding="UTF-8"?>
<com.arkea.jenkins.openstack.heat.HOTPlayerSettings plugin="openstack-heat@1.3">
  <loader class="com.arkea.jenkins.openstack.heat.loader.LoaderFromDir">
    <pathHot>/tmp</pathHot>
    <extHot>yaml</extHot>
    <checkEnv>false</checkEnv>
    <extEnv>yaml</extEnv>
  </loader>
  <timersOS>
    <pollingStatus>20</pollingStatus>
    <timeoutProcess>900</timeoutProcess>
  </timersOS>
  <projects>
    <com.arkea.jenkins.openstack.heat.configuration.ProjectOS>
      <project>service</project>
      <url>http://keystone.openstack.svc.cluster.local/v3</url>
      <checkV3>true</checkV3>
      <domain>default</domain>
      <user>{{ .Values.endpoints.identity.auth.jenkins.username }}</user>
      <password>{{ .Values.endpoints.identity.auth.jenkins.password }}</password>
      <region>RegionOne</region>
    </com.arkea.jenkins.openstack.heat.configuration.ProjectOS>
  </projects>
</com.arkea.jenkins.openstack.heat.HOTPlayerSettings>

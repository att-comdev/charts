# this is minimalist db.properties file for running artifactory via
# helm talking to mysql
#
# it should be made available to the artifactory user and writable as
# it will be updated with an encrypted password

type=mysql
driver=com.mysql.jdbc.Driver

# namespace not given, do not not use fqdn
url=jdbc:mysql://mariadb:3306/artifactory?characterEncoding=UTF-8&elideSetAutoCommits=true

username={{ .Values.endpoints.oslo_db.auth.artifactory.username }}
password={{ .Values.endpoints.oslo_db.auth.artifactory.password }}

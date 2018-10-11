#!/usr/bin/python
#
# generate a suitable proxy.xml for jenkins using environment
# variables (which ignores these)

from urlparse import urlparse
import os
import sys

for ev in ( "http_proxy", "https_proxy", "HTTP_PROXY", "HTTPS_PROXY" ):
    proxy_url = os.getenv(ev)
    if proxy_url:
        break

if not proxy_url:
    print "INFO: No proxy environment variables, proxy.xml will not be generated"
    sys.exit(0)

o = urlparse(proxy_url)

if not o.hostname:
    print "WARNING: unable to parse proxy environment variable (%s=%s)" % (ev, proxy_url)
    sys.exit(0)

port = o.port
# if for some reason the port isn't given assume 80; arguably this
# depends on the protocol used but jenkins doesn't seem to support
# proxy over https ... so best effort
if not port:
    port = 80
    print "WARNING: port not explicitly specified, assuming %d" % port

# $NO_PROXY uses commas as a separator, xml wants \n; remove spaces
# and omit empty values
no_proxy = os.getenv("NO_PROXY")
if not no_proxy:
    no_proxy = ""
no_proxy = "\n".join([ s.strip()  for s in no_proxy.split(",")  if len(s)>1 ])

proxy_config="""
<?xml version="1.0" encoding="UTF-8"?>
<proxy>
  <name>%s</name>
  <port>%s</port>
  <noProxyHost>%s</noProxyHost>
  <secretPassword/>
</proxy>
""" % (o.hostname, port, no_proxy)
proxy_config = proxy_config.strip() + "\n"


cfg_filename = os.getenv("JENKINS_PROXY_CONFIG_FILE")
if not cfg_filename:
    cfg_filename = "/var/jenkins_home/proxy.xml"

try:
    open(cfg_filename, "w").write(proxy_config)
    msg = "configuration file\n\n" + proxy_config + "\nwritten to %s" % cfg_filename
    print "\n".join([ "INFO: %s" %s  for s in msg.split("\n") ])
except:
    print "WARNING: unable to create %s" % cfg_filename

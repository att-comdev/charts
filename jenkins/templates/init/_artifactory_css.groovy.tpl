import jenkins.model.Jenkins;
def env = Jenkins.instance.getGlobalNodeProperties()[0].getEnvVars() 
//this should leave us with just the artifactory url e.g. https://artifacts-nc.mtn57z.cci.att.com
def artifactory_root = env.ARTIFACTS_URL.substring(0, env.ARTIFACTS_URL.lastIndexOf("/"))
System.setProperty("hudson.model.DirectoryBrowserSupport.CSP","sandbox allow-scripts allow-popups; " +
                    "script-src 'unsafe-inline' 'unsafe-eval' 'self' " +
                    "${artifactory_root}; " +
                    "style-src 'unsafe-inline' 'unsafe-eval' 'self' " +
                    "${artifactory_root}; " +
                    "font-src 'unsafe-inline' 'unsafe-eval' 'self' " +
                    "${artifactory_root}; ")

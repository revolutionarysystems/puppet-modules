define help-repository ($version="", $deploy_name="help-repository"){
  include tomcat7
  tomcat-nexus-war{ "help-repository-service.war":
    nexus_url => "build.revsys.co.uk/nexus",
    nexus_repo => "snapshots",
    groupId => "uk.co.revsys.help-repository",
    artifactId => "help-repository-service",
    version => $version,
    deploy_name => $deploy_name
  }
}
define oddball ($version="", $deploy_name="oddball", $config_container="", $config_path="", $consumers="", $kinesis_application_name="", $kinesis_stream=""){
  include tomcat7
  tomcat-nexus-war{ "oddball-service.war":
    nexus_url => "build.revsys.co.uk/nexus",
    nexus_repo => "snapshots",
    groupId => "uk.co.revsys.oddball",
    artifactId => "oddball-service",
    version => $version,
    deploy_name => $deploy_name
  }
  file { "/var/lib/tomcat7/webapps/${deploy_name}/WEB-INF/classes/oddball.properties":
    require => Tomcat-Nexus-War["oddball-service.war"],
    ensure => "present",
    content => template("oddball/oddball.properties.erb"),
    notify => Service["tomcat7"]
  }
}
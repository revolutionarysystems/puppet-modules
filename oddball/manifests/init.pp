define oddball ($version="", $deploy_name="oddball", $config_container="", $config_path="", $consumers="", $kinesis_application_name="", $kinesis_stream="", $user_manager_db_host="", $security_administrator_role="oddball:administrator", $datastore_host="", $datastore_port="27017"){
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
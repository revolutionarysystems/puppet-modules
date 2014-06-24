class user-manager ($version="LATEST", $deploy_name="user-manager", $db_host="localhost"){
  tomcat-nexus-war{ "user-manager-service.war":
    nexus_url => "build.revsys.co.uk/nexus",
    nexus_repo => "snapshots",
    groupId => "uk.co.revsys.user-manager",
    artifactId => "user-manager-service",
    version => $version,
    deploy_name => $deploy_name
  }
  file { "/var/lib/tomcat7/webapps/${deploy_name}/WEB-INF/classes/user-manager.properties":
    require => File["/var/lib/tomcat7/webapps/${deploy_name}"],
    ensure => "present",
    content => template("user-manager/user-manager.properties.erb"),
    notify => Service["tomcat7"]
  }
}
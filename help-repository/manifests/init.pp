define help-repository ($version="", $deploy_name="help-repository", $security="disabled", $user_manager_db_host="localhost", $security_administrator_role="administrator"){
  tomcat-nexus-war{ "help-repository-service.war":
    nexus_url => "build.revsys.co.uk/nexus",
    nexus_repo => "snapshots",
    groupId => "uk.co.revsys.help-repository",
    artifactId => "help-repository-service",
    version => $version,
    deploy_name => $deploy_name
  }
  file { "/var/lib/tomcat7/webapps/${deploy_name}/WEB-INF/classes/help-repository.properties":
    require => File["/var/lib/tomcat7/webapps/${deploy_name}"],
    ensure => "present",
    content => template("help-repository/help-repository.properties.erb"),
    notify => Service["tomcat7"]
  }
  file {["/opt/help-repository", "/opt/help-repository/binaries", "/opt/help-repository/content"]:
    mode => 777,
    ensure => "directory",
  }
}
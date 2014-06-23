class resource-repository ($version="LATEST", $deployName="resource-repository"){
  class {"tomcat7": }
  nexus-artifact::war{ "resource-repository-service.war":
    url => "build.revsys.co.uk/nexus",
    repo => "snapshots",
    groupId => "uk.co.revsys.cloud",
    artifactId => "resource-repository-service",
    version => $version
  }
  file { "/var/lib/tomcat7/webapps/${deployName}":
    require => Nexus-Artifact::War["resource-repository-service.war"],
    ensure => "directory",
    recurse => true,
    purge => true,
    source => "/opt/puppet/artifacts/resource-repository-service"
  }
  file { "/var/lib/tomcat7/webapps/${deployName}/WEB-INF/classes/resource-repository.properties":
    require => File["/var/lib/tomcat7/webapps/${deployName}"],
    ensure => "present",
    content => template("resource-repository/resource-repository.properties.erb"),
    notify => Service["tomcat7"]
  }
}
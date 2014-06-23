class resource-repository ($version="LATEST", $deploy_name="resource-repository", $cloud_container=""){
  class {"tomcat7": }
  nexus-artifact::war{ "resource-repository-service.war":
    url => "build.revsys.co.uk/nexus",
    repo => "snapshots",
    groupId => "uk.co.revsys.resource-repository",
    artifactId => "resource-repository-service",
    version => $version
  }
  file { "/var/lib/tomcat7/webapps/${deploy_name}":
    require => Nexus-Artifact::War["resource-repository-service.war"],
    ensure => "directory",
    recurse => true,
    purge => true,
    source => "/opt/puppet/artifacts/resource-repository-service"
  }
  file { "/var/lib/tomcat7/webapps/${deploy_name}/WEB-INF/classes/resource-repository.properties":
    require => File["/var/lib/tomcat7/webapps/${deploy_name}"],
    ensure => "present",
    content => template("resource-repository/resource-repository.properties.erb"),
    notify => Service["tomcat7"]
  }
}
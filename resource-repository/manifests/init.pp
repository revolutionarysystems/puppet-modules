class resource-repository ($version="LATEST", $deployName="resource-repository"){
  class {"tomcat7": }
  class {"nexus-artifact":
    url => "build.revsys.co.uk/nexus",
    repo => "snapshots",
    groupId => "uk.co.revsys.cloud",
    artifactId => "resource-repository",
    version => $version,
    type => "war"
  }
  file { "resource-repository.war":
    require => Class["nexus-artifact"],
    path => "/var/lib/tomcat7/webapps/${deployName}.war",
    ensure => "present",
    source => "/opt/puppet/artifacts/resource-repository.war"
  }

  file { "resource-repository.properties":
    require => File["resource-repository.war"],
    path => "/var/lib/tomcat7/webapps/${deployName}/WEB-INF/classes/resource-repository.properties",
    ensure => "present",
    content => template("resource-repository/resource-repository.properties.erb"),
    notify => Service["tomcat7"]
  }
}
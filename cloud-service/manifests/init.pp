class cloud-service ($version="LATEST", $deployName="cloud-service"){
  include tomcat7
  package { "unzip":
    ensure => present,
  }
  file {"/opt/puppet/artifacts/cloud-service": 
    ensure => directory
  }
  class {"nexus-artifact":
    url => "build.revsys.co.uk/nexus",
    repo => "snapshots",
    groupId => "uk.co.revsys.cloud",
    artifactId => "cloud-service",
    version => $version,
    type => "war"
  }
  exec { "extract-cloud-service":
    require => [Package["unzip"], File["/opt/puppet/artifacts/cloud-service"]],
    command => "/usr/bin/unzip ../cloud-service.war",
    cwd => "/opt/puppet/artifacts/cloud-service",
  }
  file { "/var/lib/tomcat7/webapps/${deployName}":
    ensure => "directory",
    recurse => true,
    purge => true,
    source => "/opt/puppet/artifacts/cloud-service"
  }
  file { "cloud-service.properties":
    require => File["/var/lib/tomcat7/webapps/${deployName}"],
    path => "/var/lib/tomcat7/webapps/${deployName}/WEB-INF/classes/cloud-service.properties",
    ensure => "present",
    content => template("cloud-service/cloud-service.properties.erb"),
    notify => Service["tomcat7"]
  }
}
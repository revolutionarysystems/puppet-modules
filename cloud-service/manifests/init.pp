class cloud-service ($version="LATEST", $deployName="cloud-service"){
  include tomcat7
  class {"nexus-artifact":
    url => "build.revsys.co.uk/nexus",
    repo => "snapshots",
    groupId => "uk.co.revsys.cloud",
    artifactId => "cloud-service",
    version => $version,
    type => "war"
  }
  file { "cloud-service.war":
    require => Class["nexus-artifact"],
    path => "/var/lib/tomcat7/webapps/${deployName}.war",
    ensure => "present",
    source => "/opt/puppet/artifacts/cloud-service.war"
  }

  file { "cloud-service.properties":
    require => File["cloud-service.war"],
    path => "/var/lib/tomcat7/webapps/${deployName}/WEB-INF/classes/cloud-service.properties",
    ensure => "present",
    content => template("cloud-service/cloud-service.properties.erb"),
    notify => Service["tomcat7"]
  }
}
class cloud-service ($version="LATEST", $deployName="cloud-service"){
  include tomcat7
  nexus::war {"cloud-service.war":
    url => "build.revsys.co.uk/nexus",
    repo => "snapshots",
    groupId => "uk.co.revsys.cloud",
    artifactId => "cloud-service",
    version => $version,
  }
  file { "/var/lib/tomcat7/webapps/${deployName}":
    require => Nexus::War["cloud-service.war"],
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
class cloud-dashboard ($version="LATEST", $deployName="cloud-dashboard"){
  class {"tomcat7": }
  class {"haven-artifact":
    url => "build.revsys.co.uk/haven-repository",
    artifactId => "cloud-dashboard",
    version => $version
  }
  file { "cloud-dashboard.war":
    require => Class["haven-artifact"],
    path => "/var/lib/tomcat7/webapps/${deployName}.war",
    ensure => "present",
    source => "/opt/puppet/artifacts/cloud-dashboard.war"
  }
  file { "config.js":
    require => File["cloud-dashboard.war"],
    path => "/var/lib/tomcat7/webapps/${deployName}/js/config.js",
    ensure => "present",
    content => template("cloud-dashboard/config.js"),
    notify => Service["tomcat7"]
  }
}
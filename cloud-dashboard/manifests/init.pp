class cloud-dashboard ($version="LATEST", $serviceUrl="/cloud-service/", $deployName="cloud-dashboard"){
  include tomcat7
  class {"haven-artifact":
    url => "build.revsys.co.uk/haven-repository",
    artifactId => "cloud-dashboard",
    version => $version,
    type => "zip"
  }
  file { "cloud-dashboard.zip":
    require => Class["haven-artifact"],
    path => "/var/lib/tomcat7/webapps/${deployName}.war",
    ensure => "present",
    source => "/opt/puppet/artifacts/cloud-dashboard.zip"
  }
  file { "config.js":
    require => File["cloud-dashboard.zip"],
    path => "/var/lib/tomcat7/webapps/${deployName}/js/config.js",
    ensure => "present",
    content => template("cloud-dashboard/config.js"),
    notify => Service["tomcat7"]
  }
}
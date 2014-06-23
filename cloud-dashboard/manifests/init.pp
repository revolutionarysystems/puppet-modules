class cloud-dashboard ($version="LATEST", $serviceUrl="/cloud-service/", $deployName="cloud-dashboard"){
  include tomcat7
  archive { "cloud-dashboard.tar.gz":
    ensure => present,
    url => "http://build.revsys.co.uk/haven-repository/cloud-dashboard/0.1.0/artifact/cloud-dashboard.tar.gz",
    target => "/opt/puppet/artifacts/"
  }
  file { "/var/lib/tomcat7/webapps/${deployName}":
    ensure => "directory",
    recurse => true,
    purge => true,
    source => "/opt/puppet/artifacts/cloud-dashboard"
  }
  file { "config.js":
    require => File["/var/lib/tomcat7/webapps/${deployName}"],
    path => "/var/lib/tomcat7/webapps/${deployName}/js/config.js",
    ensure => "present",
    content => template("cloud-dashboard/config.js"),
    notify => Service["tomcat7"]
  }
}
class cloud-dashboard ($version="LATEST", $serviceUrl="/cloud-service/", $deployName="cloud-dashboard"){
  include tomcat7
  file {"/opt/puppet/artifacts/${artifactId}":
    ensure => "directory"
  }
  class {"haven-artifact":
    requires => File["/opt/puppet/artifacts/${artifactId}],
    url => "build.revsys.co.uk/haven-repository",
    artifactId => "cloud-dashboard",
    version => $version,
    type => "zip"
  }
  archive { "/opt/puppet/artifacts/cloud-dashboard.zip":
    require => Class["haven-artifact"],
    ensure => unpacked,
    cwd    => "/opt/puppet/artifacts/${artifactId}",
  }
  file { "/var/lib/tomcat7/webapps/${deployName}":
    ensure => "directory",
    recurse => true,
    purge => true,
    source => "/opt/puppet/artifacts/cloud-dashboard"
  }
  file { "config.js":
    require => File[/var/lib/tomcat7/webapps/${deployName}],
    path => "/var/lib/tomcat7/webapps/${deployName}/js/config.js",
    ensure => "present",
    content => template("cloud-dashboard/config.js"),
    notify => Service["tomcat7"]
  }
}
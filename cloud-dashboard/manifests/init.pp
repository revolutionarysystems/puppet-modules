class cloud-dashboard ($version="LATEST", $serviceUrl="/cloud-service/", $deployName="cloud-dashboard"){
  include tomcat7
  file {"/opt/puppet/artifacts/cloud-dashboard":
    ensure => "directory"
  }
  class {"haven-artifact":
    require => File["/opt/puppet/artifacts/cloud-dashboard"],
    url => "build.revsys.co.uk/haven-repository",
    artifactId => "cloud-dashboard",
    version => $version,
    type => "zip"
  }
  exec { "extract-cloud-dashboard":
    require => File["/opt/puppet/artifacts/cloud-dashboard"],
    command => "/bin/tar -zxvf ../cloud-dashboard.tar.gz",
    cwd => "/opt/puppet/artifacts/cloud-dashboard",
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
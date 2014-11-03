class cloud-dashboard ($version="LATEST", $serviceUrl="/cloud-service/", $deployName="cloud-dashboard"){
  file {"/opt/puppet/artifacts/cloud-dashboard":
    ensure => "directory"
  }
  haven-artifact { "cloud-dashboard.tar.gz": 
    require => File["/opt/puppet/artifacts/cloud-dashboard"],
    url => "build.revsys.co.uk/haven-repository",
    artifactId => "cloud-dashboard",
    version => $version,
    type => "tar.gz"
  }
  exec { "extract-cloud-dashboard":
    require => [File["/opt/puppet/artifacts/cloud-dashboard"], Haven-Artifact["cloud-dashboard.tar.gz"]],
    command => "/bin/tar -zxf ../cloud-dashboard.tar.gz",
    cwd => "/opt/puppet/artifacts/cloud-dashboard",
  }
  file { "/var/lib/tomcat7/webapps/${deployName}":
    require => Exec["extract-cloud-dashboard"],
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
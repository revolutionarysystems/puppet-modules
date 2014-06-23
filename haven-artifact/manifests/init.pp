class haven-artifact ($url="", $artifactId="", $version="") {
  include puppet-artifacts
  file {["/opt/puppet/artifacts/${artifactId}"]:
    ensure => "directory"
  }
  exec { "haven-wget":
    require => File["/opt/puppet/artifacts/${artifactId}"],
    command => "/usr/bin/wget -N '${url}/${artifactId}/${version}/artifact'",
    cwd => "/opt/puppet/artifacts/${artifactId}",
  }
}
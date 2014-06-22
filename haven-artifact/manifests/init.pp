class haven-artifact ($url="", $artifactId="", $version="") {
  file {["/opt/puppet", "/opt/puppet/artifacts", "/opt/puppet/artifacts/${artifactId}"]:
    ensure => "directory"
  }
  exec { "haven-wget":
    require => File["/opt/puppet/artifacts/${artifactId}"],
    command => "/usr/bin/wget -N '${url}/${artifactId}/${version}/artifact'",
    cwd => "/opt/puppet/artifacts/${artifactId}",
  }
}
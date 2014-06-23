define haven-artifact ($url="", $artifactId="", $version="", $type="") {
  include puppet-artifacts
  exec { "haven-wget-${artifactId}":
    require => File["/opt/puppet/artifacts/"],
    command => "/usr/bin/wget -N '${url}/${artifactId}/${version}/artifact/${artifactId}.${type}'",
    cwd => "/opt/puppet/artifacts/",
  }
}
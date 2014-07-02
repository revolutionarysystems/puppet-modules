define haven-artifact ($url="", $artifactId="", $version="", $type="") {
  haven-artifact::file { "haven-artifact-file-${artifactId}":
    url => $url,
    artifactId => $artifactId,
    version => $version,
    file => "${artifactId}.${type}"
  }
}

define haven-artifact::file ($url="", $artifactId="", $version="", $file="") {
  include puppet-artifacts
  exec { "haven-wget-${file}":
    require => File["/opt/puppet/artifacts/"],
    command => "/usr/bin/wget -N '${url}/${artifactId}/${version}/artifact/${file}'",
    cwd => "/opt/puppet/artifacts/",
  }
}

define haven-artifact::tar ($url="", $artifactId="", $version="", $file="") {
  file {"/opt/puppet/artifacts/${file}": 
    ensure => directory
  }
  haven-artifact::file { "haven-artifact-file-${file}":
    url => $url,
    artifactId => $artifactId,
    version => $version,
    file => "${file}.tar.gz"
  }
  exec { "extract-${file}":
    require => [File["/opt/puppet/artifacts/${file}"], Haven-Artifact::File["haven-artifact-file-${file}"]],
    command => "/bin/tar -zxvf ../${file}.tar.gz",
    cwd => "/opt/puppet/artifacts/${file}",
  }
}
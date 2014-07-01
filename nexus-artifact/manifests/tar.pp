define nexus-artifact::tar ($url="", $repo="", $groupId="", $artifactId="", $version=""){
    file {"/opt/puppet/artifacts/${artifactId}": 
      ensure => directory
    }
    nexus-artifact{"${groupId}.${artifactId}.${version}":
        url => $url,
        repo => $repo,
        groupId => $groupId,
        artifactId => $artifactId,
        version => $version,
        type => "tar.gz"
    }
    exec { "extract-${artifactId}":
      require => [File["/opt/puppet/artifacts/${artifactId}"], Nexus-Artifact["${groupId}.${artifactId}.${version}"]],
      command => "/bin/tar -zxvf ../${artifactId}.tar.gz",
      cwd => "/opt/puppet/artifacts/${artifactId}",
    }
}
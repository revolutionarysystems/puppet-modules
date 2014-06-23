define nexus-artifact::war ($url="", $repo="", $groupId="", $artifactId="", $version=""){
    package { "unzip":
        ensure => present,
    }
    file {"/opt/puppet/artifacts/${artifactId}": 
      ensure => directory
    }
    nexus-artifact{"${groupId}.${artifactId}.${version}":
        url => $url,
        repo => $repo,
        groupId => $groupId,
        artifactId => $artifactId,
        version => $versionId,
        type => "war"
    }
    exec { "extract-${artifactId}":
      require => [Package["unzip"], File["/opt/puppet/artifacts/${artifactId}"], Nexus::Artifact["${groupId}.${artifactId}.${version}"]],
      command => "/usr/bin/unzip -o ../${artifactId}.war",
      cwd => "/opt/puppet/artifacts/${artifactId}",
    }
}
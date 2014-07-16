define nexus-artifact::war ($url="", $repo="", $groupId="", $artifactId="", $version=""){
    include unzip
    file {"/opt/puppet/artifacts/${artifactId}":
      ensure => directory
    }
    nexus-artifact{"${groupId}.${artifactId}.${version}":
        url => $url,
        repo => $repo,
        groupId => $groupId,
        artifactId => $artifactId,
        version => $version,
        type => "war"
    }
    exec { "extract-${artifactId}":
      require => [Package["unzip"], File["/opt/puppet/artifacts/${artifactId}"], Nexus-Artifact["${groupId}.${artifactId}.${version}"]],
      command => "/bin/rm -rf ./* && /usr/bin/unzip -o ../${artifactId}.war && echo 1 > .puppet",
      cwd => "/opt/puppet/artifacts/${artifactId}",
      unless => "/usr/bin/find -name .puppet -newer ../${artifactId}.war | grep -c '.*'"
    }
}

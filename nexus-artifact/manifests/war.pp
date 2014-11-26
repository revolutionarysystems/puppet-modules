define nexus-artifact::war ($url="", $repo="", $groupId="", $artifactId="", $version="", $deploy_name=""){
    include unzip
    file {"/opt/puppet/artifacts/${artifactId}-${deploy_name}":
      ensure => directory
    }
    nexus-artifact{"${groupId}.${artifactId}.${version}.${deploy_name}":
        url => $url,
        repo => $repo,
        groupId => $groupId,
        artifactId => $artifactId,
        version => $version,
        type => "war"
    }
    exec { "extract-${artifactId}-${deploy_name}":
      require => [Package["unzip"], File["/opt/puppet/artifacts/${artifactId}-${deploy_name}"], Nexus-Artifact["${groupId}.${artifactId}.${version}.${deploy_name}"]],
      command => "/bin/rm -rf ./* && /usr/bin/unzip -o ../${artifactId}.war && echo 1 > .puppet",
      cwd => "/opt/puppet/artifacts/${artifactId}-${deploy_name}",
      unless => "/usr/bin/find -name .puppet -newer ../${artifactId}.war | grep -c '.*'"
    }
}

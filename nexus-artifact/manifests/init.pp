define nexus::artifact ($url="", $repo="", $groupId="", $artifactId="", $version="", $type="jar") {
  include puppet-artifacts
  $sourceName = "redirect?r=${repo}&g=${groupId}&a=${artifactId}&v=${version}&p=${type}"
  $escapedSourceName = "redirect\?r\=${repo}\&g\=${groupId}\&a\=${artifactId}\&v\=${version}\&p\=${type}"
  $destName = "${artifactId}.${type}"
  exec { "nexus-wget":
    require => File["/opt/puppet/artifacts/tmp"],
    command => "/usr/bin/wget -N '${url}/service/local/artifact/maven/$sourceName'",
    cwd => "/opt/puppet/artifacts/tmp",
  }
  exec { "nexus-copy-artifact":
    command => "/bin/cp ${escapedSourceName} ${destName}",
    cwd => "/opt/puppet/artifacts/tmp",
    subscribe => Exec["nexus-wget"]
  }
  file { "nexus-artifact":
    path => "/opt/puppet/artifacts/${destName}",
    ensure => "present",
    source => "/opt/puppet/artifacts/tmp/${destName}",
    require => Exec["nexus-copy-artifact"]
  }
}

define nexus::war ($url="", $repo="", $groupId="", $artifactId="", $version=""){
    package { "unzip":
        ensure => present,
    }
    file {"/opt/puppet/artifacts/${artifactId}": 
      ensure => directory
    }
    nexus::artifact{"${groupId}.${artifactId}.${version}":
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
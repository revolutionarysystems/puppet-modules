class nexus-artifact ($url="", $repo="", $groupId="", $artifactId="", $version="", $type="jar") {
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
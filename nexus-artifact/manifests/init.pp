define nexus-artifact($url="", $repo="", $groupId="", $artifactId="", $version="", $type="jar", $deploy_name="") {
  include puppet-artifacts
  $sourceName = "redirect?r=${repo}&g=${groupId}&a=${artifactId}&v=${version}&p=${type}"
  $escapedSourceName = "redirect\?r\=${repo}\&g\=${groupId}\&a\=${artifactId}\&v\=${version}\&p\=${type}"
  $destName = "${artifactId}.${type}"
  exec { "nexus-wget-${artifactId}-${deploy_name}":
    require => File["/opt/puppet/artifacts/tmp"],
    command => "/usr/bin/wget -N '${url}/service/local/artifact/maven/$sourceName'",
    cwd => "/opt/puppet/artifacts/tmp",
  }
  exec { "nexus-copy-artifact-${artifactId}-${deploy_name}":
    command => "/bin/cp -p ${escapedSourceName} ../${destName}",
    cwd => "/opt/puppet/artifacts/tmp",
    subscribe => Exec["nexus-wget-${artifactId}-${deploy_name}"]
  }
}

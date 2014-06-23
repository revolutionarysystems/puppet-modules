define nexus($url="", $repo="", $groupId="", $artifactId="", $version="", $type="jar") {
  nexus::artifact{"${groupId}.${artifactId}.${version}":
    url => $url,
    repo => $repo,
    groupId => $groupId,
    artifactId => $artifactId,
    version => $versionId,
    type => $type
  }
}
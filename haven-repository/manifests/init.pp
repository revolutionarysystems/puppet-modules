class haven-repository ($version="LATEST", $deploy_name="haven-repository", $repository_type="cloud", $resource_container=""){
  class {"resource-repository":
    version => $version,
    deploy_name => $deploy_name,
    repository_type => $repository_type,
    resource_container => $resource_container
  }
}
class haven-repository ($version="LATEST", $deploy_name="haven-repository", $cloud_container=""){
  class {"resource-repository":
    version => $version,
    deploy_name => $deploy_name,
    cloud_container => $cloud_container
  }
}
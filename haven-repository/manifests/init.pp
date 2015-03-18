class haven-repository ($version="LATEST", $deploy_name="haven-repository", $repository_type="cloud", $resource_container="", $security="disabled", $security_role="", $user_manager_db_host=""){
  class {"resource-repository":
    version => $version,
    deploy_name => $deploy_name,
    repository_type => $repository_type,
    resource_container => $resource_container
    security => $security,
    security_role => $security_role,
    user_manager_db_host => $user_manager_db_host
  }
}
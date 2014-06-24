define subscription-manager ($version="LATEST", $deploy_name="subscription-manager", $db_host="localhost", $db_name="subscription-manager", $templates_version="LATEST"){
  objectology{"subscription-manager": 
    version=> $version,
    deploy_name => $deploy_name,
    db_host => $db_host,
    db_name => $db_name,
    cloud_container => "revsys-haven-artifacts",
    resources_path => "/subscription-manager-templates/${templates_version}/artifact/"
  }
}
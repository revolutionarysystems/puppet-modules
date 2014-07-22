define subscription-manager ($version="LATEST", $deploy_name="subscription-manager", $db_host="localhost", $db_name="subscription-manager", $templates_version="LATEST", $instance_container="", $instance_path=""){
  objectology{"subscription-manager": 
    version=> $version,
    deploy_name => $deploy_name,
    db_host => $db_host,
    db_name => $db_name,
    template_repository_type => "cloud",
    template_container => "revsys-haven-artifacts",
    template_path => "subscription-manager-templates/${templates_version}/artifact",
    instance_repository_type => "cloud",
    instance_container => $instance_container,
    instance_path => $instance_path
  }
}
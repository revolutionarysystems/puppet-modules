define help-repository-h2 ($version="", $deploy_name="help-repository", $security="disabled", $user_manager_db_host="localhost", $security_administrator_role="administrator"){
  
  help-repository{"h2": 
    version => $version,
    deploy_name => $deploy_name,
    security => $security,
    user_manager_db_host => $user_manager_db_host,
    security_administrator_role => $security_administrator_role
  }
  
  file {["/opt/help-repository", "/opt/help-repository/binaries", "/opt/help-repository/content"]:
    mode => 777,
    ensure => "directory",
  }
}
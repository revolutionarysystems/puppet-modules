define help-repository-mysql ($version="", $deploy_name="help-repository", $security="disabled", $user_manager_db_host="localhost", $security_administrator_role="administrator", $db_host="localhost", $db_name="", $binary_db_name="", $db_user="", $db_password=""){
  help-repository{"mysql": 
    version => $version,
    deploy_name => $deploy_name,
    security => $security,
    user_manager_db_host => $user_manager_db_host,
    security_administrator_role => $security_administrator_role
  }
  file { "/var/lib/tomcat7/webapps/${deploy_name}/WEB-INF/classes/repository.json":
    require => File["/var/lib/tomcat7/webapps/${deploy_name}"],
    ensure => "present",
    content => template("help-repository-mysql/repository.json.erb"),
    notify => Service["tomcat7"]
  }
  file { "/var/lib/tomcat7/webapps/${deploy_name}/WEB-INF/classes/infinispan-configuration.xml":
    require => File["/var/lib/tomcat7/webapps/${deploy_name}"],
    ensure => "present",
    content => template("help-repository-mysql/infinispan-configuration.xml.erb"),
    notify => Service["tomcat7"]
  }
}
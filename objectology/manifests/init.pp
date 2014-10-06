define objectology ($version="LATEST", $deploy_name="objectology", $db_host="localhost", $db_name="objectology", $template_repository_type="cloud", $template_container="", $template_path="/", $instance_repository_type="cloud", $instance_container="", $instance_path="/", $view_repository_type="cloud", $view_container="", $view_path="/", $security="default", $user_manager_db_host="", $security_administrator_role=""){
  tomcat-nexus-war{ "objectology-webapp.war":
    nexus_url => "build.revsys.co.uk/nexus",
    nexus_repo => "snapshots",
    groupId => "uk.co.revsys.objectology",
    artifactId => "objectology-webapp",
    version => $version,
    deploy_name => $deploy_name
  }
  file { "/var/lib/tomcat7/webapps/${deploy_name}/WEB-INF/classes/objectology.properties":
    require => File["/var/lib/tomcat7/webapps/${deploy_name}"],
    ensure => "present",
    content => template("objectology/objectology.properties.erb"),
    notify => Service["tomcat7"]
  }
}
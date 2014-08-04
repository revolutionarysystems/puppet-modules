define subscription-manager ($version="LATEST", $deploy_name="subscription-manager", $db_host="localhost", $db_name="subscription-manager", $templates_version="LATEST", $instance_container="", $instance_path="", $user_manager_db_host="", $security="default", $security_administrator_role="subscription-manager:administrator"){

  $template_repository_type => "cloud"
  $template_container => "revsys-haven-artifacts"
  $template_path => "subscription-manager-templates/${templates_version}/artifact"
  $instance_repository_type => "cloud"

  tomcat-nexus-war{ "subscription-manager-webapp.war":
    nexus_url => "build.revsys.co.uk/nexus",
    nexus_repo => "snapshots",
    groupId => "uk.co.revsys.subscription-manager",
    artifactId => "subscription-manager-webapp",
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
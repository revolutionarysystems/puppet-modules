define ui-framework-with-forms ($version="LATEST", $repo="releases", $deploy_name="ui-framework-with-forms", $repository_type="cloud", $resources_container="", $resources_path="", $cloud_identity="", $cloud_credential="", $security_filters="none", $user_manager_url="", $user_manager_db_host="", $login_url="/login.html", $login_success_url="index.html", $show_forms_debug_bar="false"){
  tomcat-nexus-war{ "ui-framework-with-forms-${deploy_name}.war":
    nexus_url => "build.revsys.co.uk/nexus",
    nexus_repo => $repo,
    groupId => "uk.co.revsys",
    artifactId => "ui-framework-with-forms",
    version => $version,
    deploy_name => $deploy_name,
    purge => false
  }
  file { "/var/lib/tomcat7/webapps/${deploy_name}/WEB-INF/classes/ui.properties":
    require => File["/var/lib/tomcat7/webapps/${deploy_name}"],
    ensure => "present",
    content => template("ui-framework-with-forms/ui.properties.erb"),
    notify => Service["tomcat7"]
  }
  file { "/var/lib/tomcat7/webapps/${deploy_name}/WEB-INF/classes/Rhinoforms.properties":
    require => File["/var/lib/tomcat7/webapps/${deploy_name}"],
    ensure => "present",
    content => template("ui-framework-with-forms/Rhinoforms.properties.erb"),
    notify => Service["tomcat7"]
  }
}
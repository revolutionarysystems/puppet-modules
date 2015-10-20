define ui-framework ($version="LATEST", $repo="releases", $deploy_name="ui-framework", $repository_type="cloud", $resources_container="", $resources_path="", $security_filters="none", $user_manager_url="", $user_manager_db_host="localhost", $cloud_identity="", $cloud_credential="", $login_url="/login.html", $login_success_url="index.html", $account_shield_url="", $account_shield_username="", $account_shield_password=""){
  tomcat-nexus-war{ "ui-framework-${deploy_name}.war":
    nexus_url => "build.revsys.co.uk/nexus",
    nexus_repo => $repo,
    groupId => "uk.co.revsys",
    artifactId => "ui-framework",
    version => $version,
    deploy_name => $deploy_name,
    purge => false
  }
  file { "/var/lib/tomcat7/webapps/${deploy_name}/WEB-INF/classes/ui.properties":
    require => File["/var/lib/tomcat7/webapps/${deploy_name}"],
    ensure => "present",
    content => template("ui-framework/ui.properties.erb"),
    notify => Service["tomcat7"]
  }
}
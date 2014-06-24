define ui-framework ($version="LATEST", $deploy_name="ui-framework", $cloud_container="", $resources_path="", $user_manager_url=""){
  tomcat-nexus-war{ "ui-framework.war":
    nexus_url => "build.revsys.co.uk/nexus",
    nexus_repo => "snapshots",
    groupId => "uk.co.revsys",
    artifactId => "ui-framework",
    version => $version,
    deploy_name => $deploy_name
  }
  file { "/var/lib/tomcat7/webapps/${deploy_name}/WEB-INF/classes/ui-framework.properties":
    require => File["/var/lib/tomcat7/webapps/${deploy_name}"],
    ensure => "present",
    content => template("ui-framework/ui-framework.properties.erb"),
    notify => Service["tomcat7"]
  }
}
define tomcat-nexus-war ($nexus_url="", $nexus_repo="", $groupId="", $artifactId="", $version="LATEST", $deploy_name="", $purge="true") {
	nexus-artifact::war{ "${artifactId}-${deploy_name}.war":
		url => $nexus_url,
		repo => $nexus_repo,
		groupId => $groupId,
		artifactId => $artifactId,
		version => $version,
        deploy_name => $deploy_name
	}
	file { "/var/lib/tomcat7/webapps/${deploy_name}":
		require => Nexus-Artifact::War["${artifactId}-${deploy_name}.war"],
		ensure => "directory",
        group => "tomcat7",
        owner => "tomcat7",
		recurse => true,
        purge => $purge,
        force => true,
		source => "/opt/puppet/artifacts/${artifactId}-${deploy_name}",
        notify => Service["tomcat7"]
	}
    file { "/var/lib/tomcat7/webapps/${deploy_name}/WEB-INF":
		ensure => "directory",
        group => "tomcat7",
        owner => "tomcat7",
		recurse => true,
        purge => true,
        force => true,
		source => "/opt/puppet/artifacts/${artifactId}-${deploy_name}/WEB-INF",
        notify => Service["tomcat7"]
	}
}
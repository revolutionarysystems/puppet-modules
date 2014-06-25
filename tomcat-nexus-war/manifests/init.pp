define tomcat-nexus-war ($nexus_url="", $nexus_repo="", $groupId="", $artifactId="", $version="LATEST", $deploy_name="") {
	include tomcat7
	nexus-artifact::war{ "${artifactId}.war":
		url => $nexus_url,
		repo => $nexus_repo,
		groupId => $groupId,
		artifactId => $artifactId,
		version => $version
	}
	file { "/var/lib/tomcat7/webapps/${deploy_name}":
		require => Nexus-Artifact::War["${artifactId}.war"],
		ensure => "directory",
        group => "tomcat7",
        owner => "tomcat7",
		recurse => true,
		purge => true,
		source => "/opt/puppet/artifacts/${artifactId}"
	}
}
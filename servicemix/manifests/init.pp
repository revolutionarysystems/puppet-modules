class servicemix ($repo="releases", $smx_version="LATEST", $utils_version="LATEST", $web_listener_version="LATEST", $jsont_version="LATEST", $features="") {
  package { "default-jre":
    ensure => present
  }
  nexus-artifact::tar{ "apache-servicemix.tar.gz":
    url => "build.revsys.co.uk/nexus",
    repo => $repo,
    groupId => "uk.co.revsys.servicemix",
    artifactId => "servicemix",
    version => $smx_version
  }
  file { "/opt/apache-servicemix-4.5.2":
    require => Nexus-Artifact::Tar["apache-servicemix.tar.gz"],
    ensure => "directory",
    recurse => true,
    mode => 755,
    source => "/opt/puppet/artifacts/servicemix"
  }
  file { '/opt/servicemix':
   require => File["/opt/apache-servicemix-4.5.2"],
   ensure => 'link',
   target => '/opt/apache-servicemix-4.5.2',
  }
  file { '/etc/init.d/servicemix':
   require => File["/opt/apache-servicemix-4.5.2"],
   ensure => 'link',
   target => '/opt/servicemix/bin/karaf-service',
  }
  file { '/etc/rc0.d/K20servicemix':
   require => File["/etc/init.d/servicemix"],
   ensure => 'link',
   target => '/etc/init.d/servicemix',
  }
  file { '/etc/rc1.d/K20servicemix':
   require => File["/etc/init.d/servicemix"],
   ensure => 'link',
   target => '/etc/init.d/servicemix',
  }
  file { '/etc/rc6.d/K20servicemix':
   require => File["/etc/init.d/servicemix"],
   ensure => 'link',
   target => '/etc/init.d/servicemix',
  }
  file { '/etc/rc2.d/S20servicemix':
   require => File["/etc/init.d/servicemix"],
   ensure => 'link',
   target => '/etc/init.d/servicemix',
  }
  file { '/etc/rc3.d/S20servicemix':
   require => File["/etc/init.d/servicemix"],
   ensure => 'link',
   target => '/etc/init.d/servicemix',
  }
  file { '/etc/rc4.d/S20servicemix':
   require => File["/etc/init.d/servicemix"],
   ensure => 'link',
   target => '/etc/init.d/servicemix',
  }
  file { '/etc/rc5.d/S20servicemix':
   require => File["/etc/init.d/servicemix"],
   ensure => 'link',
   target => '/etc/init.d/servicemix',
  }
  nexus-artifact{ "esb-web-listener.jar":
    require => File["/opt/apache-servicemix-4.5.2"],
    url => "build.revsys.co.uk/nexus",
    repo => $repo,
    groupId => "uk.co.revsys.esb",
    artifactId => "esb-web-listener",
    version => $web_listener_version,
  }
  file { "/opt/apache-servicemix-4.5.2/deploy/esb-web-listener.jar": 
    require => Nexus-Artifact["esb-web-listener.jar"],
    ensure => "present",
    mode => 755,
    source => "/opt/puppet/artifacts/esb-web-listener.jar"
  }
  nexus-artifact{ "jsont-osgi.jar":
    require => File["/opt/apache-servicemix-4.5.2"],
    url => "build.revsys.co.uk/nexus",
    repo => $repo,
    groupId => "uk.co.revsys.jsont",
    artifactId => "jsont-osgi",
    version => $jsont_version,
  }
  file { "/opt/apache-servicemix-4.5.2/deploy/jsont-osgi.jar": 
    require => Nexus-Artifact["jsont-osgi.jar"],
    ensure => "present",
    mode => 755,
    source => "/opt/puppet/artifacts/jsont-osgi.jar"
  }
  nexus-artifact{ "jsont-camel.jar":
    require => File["/opt/apache-servicemix-4.5.2"],
    url => "build.revsys.co.uk/nexus",
    repo => $repo,
    groupId => "uk.co.revsys.jsont",
    artifactId => "jsont-camel",
    version => $jsont_version,
  }
  file { "/opt/apache-servicemix-4.5.2/deploy/jsont-camel.jar": 
    require => Nexus-Artifact["jsont-camel.jar"],
    ensure => "present",
    mode => 755,
    source => "/opt/puppet/artifacts/jsont-camel.jar"
  }
  nexus-artifact{ "esb-utils.jar":
    require => File["/opt/apache-servicemix-4.5.2"],
    url => "build.revsys.co.uk/nexus",
    repo => $repo,
    groupId => "uk.co.revsys.esb",
    artifactId => "esb-utils",
    version => $utils_version,
  }
  file { "/opt/apache-servicemix-4.5.2/deploy/esb-utils.jar": 
    require => Nexus-Artifact["esb-utils.jar"],
    ensure => "present",
    mode => 755,
    source => "/opt/puppet/artifacts/esb-utils.jar"
  }
  service { "servicemix":
    require => File["/etc/init.d/servicemix"],
    ensure => "running"
  }
  file { "/opt/apache-servicemix-4.5.2/etc/org.apache.karaf.features.cfg": 
    ensure => "present",
    mode => 755,
    content => template("servicemix/org.apache.karaf.features.cfg.erb")
  }
}
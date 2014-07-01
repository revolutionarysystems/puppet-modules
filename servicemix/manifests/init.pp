class servicemix () {
  nexus-artifact::tar{ "apache-servicemix.tar.gz":
    url => "build.revsys.co.uk/nexus",
    repo => "snapshots",
    groupId => "uk.co.revsys.servicemix",
    artifactId => "servicemix",
    version => "4.5.2-SNAPSHOT"
  }
  file { "/opt/servicemix":
    require => Nexus-Artifact::Tar["apache-servicemix.tar.gz"],
    ensure => "directory",
    recurse => true,
    source => "/opt/puppet/artifacts/servicemix"
  }
  file { '/etc/init.d/servicemix':
   require => File["/opt/servicemix"],
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
    require => File["/opt/servicemix"],
    url => "build.revsys.co.uk/nexus",
    repo => "snapshots",
    groupId => "uk.co.revsys.esb",
    artifactId => "esb-web-listener",
    version => "0.1.0-SNAPSHOT",
  }
  file { "/opt/servicemix/deploy/esb-web-listener.jar": 
    require => Nexus-Artifact["esb-web-listener.jar"],
    ensure => "present",
    source => "/opt/puppet/artifacts/esb-web-listener.jar"
  }
  nexus-artifact{ "jsont.jar":
    require => File["/opt/servicemix"],
    url => "build.revsys.co.uk/nexus",
    repo => "snapshots",
    groupId => "uk.co.revsys.jsont",
    artifactId => "jsont-osgi",
    version => "0.1.0-SNAPSHOT",
  }
  file { "/opt/servicemix/deploy/jsont.jar": 
    require => Nexus-Artifact["jsont.jar"],
    ensure => "present",
    source => "/opt/puppet/artifacts/jsont-osgi.jar"
  }
  service { "servicemix"
    require => File["/opt/servicemix"],
    ensure => "running"
  }
}
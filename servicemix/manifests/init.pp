class servicemix ($features="", $repo="releases", $dependencies_version="LATEST") {
  package { "default-jre":
    ensure => present
  }
  nexus-artifact::tar{ "apache-servicemix.tar.gz":
    url => "build.revsys.co.uk/nexus",
    repo => "releases",
    groupId => "uk.co.revsys.servicemix",
    artifactId => "servicemix",
    version => "4.5.2"
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
  service { "servicemix":
    require => File["/etc/init.d/servicemix"],
    ensure => "running"
  }
  file { "/opt/apache-servicemix-4.5.2/etc/org.apache.karaf.features.cfg": 
    ensure => "present",
    mode => 755,
    content => template("servicemix/org.apache.karaf.features.cfg.erb")
  }
  nexus-artifact::tar{ "esb-dependencies.tar.gz":
    url => "build.revsys.co.uk/nexus",
    repo => $repo,
    groupId => "uk.co.revsys.esb",
    artifactId => "esb-dependencies",
    version => $dependencies_version
  }
  file { "/opt/servicemix/deploy":
    require => Nexus-Artifact::Tar["esb-dependencies.tar.gz"],
    ensure => "directory",
    recurse => true,
    mode => 755,
    source => "/opt/puppet/artifacts/esb-dependencies"
  }
}
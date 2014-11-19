define ami-scripts($version="LATEST"){

    haven-artifact::tar { "ami-scripts.tar.gz":
      url => "http://build.revsys.co.uk/haven-repository",
      artifactId => "ami-scripts",
      version => $version,
      file => "ami-scripts"
    }
    
    file { "/root/ami-scripts":
      require => Haven-Artifact::Tar["ami-scripts.tar.gz"],
      ensure => "directory",
      recurse => true,
      owner => "root",
      group => "root",
      mode => 755,
      source => "/opt/puppet/artifacts/ami-scripts"
    }

}
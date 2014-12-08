class page-mirror-server ($version="LATEST") {

  include node

  include forever
  
  haven-artifact::tar { "page-mirror-server.tar.gz": 
    url => "build.revsys.co.uk/haven-repository",
    artifactId => "page-mirror-server",
    version => $version,
    file => "page-mirror-server"
  }
  
  file { "/opt/page-mirror-server":
    require => Haven-Artifact::Tar["page-mirror-server.tar.gz"],
    ensure => "directory",
    recurse => true,
    purge => true,
    source => "/opt/puppet/artifacts/page-mirror-server"
  }
  
  exec { "run_page_mirror":
    require => File['/opt/page-mirror-server'],
    cwd => "/opt/page-mirror-server",
    command => "forever start --uid page-mirror -a -w server.js",
    onlyif => "forever list | grep page-mirror | wc -l",
    path => ["/bin", "/usr/bin", "/usr/local/bin"]
  }
}
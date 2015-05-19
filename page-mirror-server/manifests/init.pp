class page-mirror-server ($version="LATEST", $port="8070", $db_type="memory", $db_host="localhost", $db_name="recordings", $db_table_recordings="recordings", $db_table_blacklist="blacklist") {

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
  
  file { "/opt/page-mirror-server/config.js":
    require => File["/opt/page-mirror-server"],
    ensure => "present",
    content => template("page-mirror-server/config.js.erb")
  }
  
  exec { "run_page_mirror":
    require => File['/opt/page-mirror-server'],
    cwd => "/opt/page-mirror-server",
    command => "forever start --uid page-mirror -a -w server.js",
    onlyif => "forever list | grep page-mirror | wc -l | grep -q 0",
    path => ["/bin", "/usr/bin", "/usr/local/bin"]
  }
}
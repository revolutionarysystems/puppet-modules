class page-mirror-service ($version="LATEST", $port="8070", $protocol="http", $ssl_key="", $ssl_cert="", $ssl_ca="", $db_type="memory", $db_host="localhost", $db_name="recordings", $db_table_recordings="recordings", $db_table_blacklist="blacklist") {

  include forever
  
  haven-artifact::tar { "page-mirror-service.tar.gz": 
    url => "build.revsys.co.uk/haven-repository",
    artifactId => "page-mirror-service",
    version => $version,
    file => "page-mirror-service"
  }
  
  file { "/opt/page-mirror-service":
    require => Haven-Artifact::Tar["page-mirror-service.tar.gz"],
    ensure => "directory",
    recurse => true,
    mode => 755,
    purge => true,
    source => "/opt/puppet/artifacts/page-mirror-service"
  }
  
  file { "/opt/page-mirror-service/config.js":
    require => File["/opt/page-mirror-service"],
    ensure => "present",
    content => template("page-mirror-service/config.js.erb")
  }
  
  exec { "run_page_mirror":
    require => File['/opt/page-mirror-service'],
    cwd => "/opt/page-mirror-service",
    command => "forever start --uid page-mirror-service -a -w service.js",
    onlyif => "forever list | grep page-mirror-service | wc -l | grep -q 0",
    path => ["/bin", "/usr/bin", "/usr/local/bin"]
  }
}
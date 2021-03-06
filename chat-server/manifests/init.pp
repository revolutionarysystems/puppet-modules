class chat-server ($version="LATEST") {

  include forever
  
  haven-artifact::tar { "chat-server.tar.gz": 
    url => "build.revsys.co.uk/haven-repository",
    artifactId => "chat-server",
    version => $version,
    file => "chat-server"
  }
  
  file { "/opt/chat-server":
    require => Haven-Artifact::Tar["chat-server.tar.gz"],
    ensure => "directory",
    recurse => true,
    purge => true,
    source => "/opt/puppet/artifacts/chat-server"
  }
  
  exec { "run_chat":
    require => File['/opt/chat-server'],
    cwd => "/opt/chat-server",
    command => "forever start --uid chat-server -a -w server.js",
    onlyif => "forever list | grep chat-server | wc -l | grep -q 0",
    path => ["/bin", "/usr/bin", "/usr/local/bin"]
  }
}
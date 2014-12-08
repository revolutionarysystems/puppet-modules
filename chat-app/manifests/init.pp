class chat-app ($version="LATEST") {

  include forever
  
  haven-artifact::tar { "chat-app.tar.gz": 
    url => "build.revsys.co.uk/haven-repository",
    artifactId => "chat-app",
    version => $version,
    file => "chat-app"
  }
  
  file { "/opt/chat-app":
    require => Haven-Artifact::Tar["chat-app.tar.gz"],
    ensure => "directory",
    recurse => true,
    purge => true,
    source => "/opt/puppet/artifacts/chat-app"
  }
  
  exec { "run_chat_app":
    require => File['/opt/chat-app'],
    cwd => "/opt/chat-app",
    command => "forever start --uid chat-app -a -w server.js",
    onlyif => "forever list | grep chat-app | wc -l",
    path => ["/bin", "/usr/bin", "/usr/local/bin"]
  }
}
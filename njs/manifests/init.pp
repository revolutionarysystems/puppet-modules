class njs {
  
  exec {'setup-node-repo':
    command => 'curl -sL https://deb.nodesource.com/setup_0.12 | sudo bash -',
    path => ["/bin", "/usr/bin", "/usr/local/bin"]
  }

  package {'nodejs':
    require => Exec['setup-node-repo'],
    ensure => present
  }  
  
  file { '/usr/bin/node':
    require => Package['nodejs'],
    ensure => 'link',
    target => '/usr/bin/nodejs'
  }
}
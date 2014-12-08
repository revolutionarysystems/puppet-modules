class njs {
  package {'nodejs':
    ensure => present
  }
  
  package{'npm':
    ensure => 'present'
  }
  
  file { '/usr/bin/node':
    require => Package['nodejs'],
    ensure => 'link',
    target => '/usr/bin/nodejs'
  }
}
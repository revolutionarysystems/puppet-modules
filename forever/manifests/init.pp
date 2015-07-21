class forever {

  include njs
  
  package { 'forever':
      require => Package['nodejs'],
      ensure   => present,
      provider => 'npm',
  }
}
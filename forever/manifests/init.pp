class forever {

  include njs
  
  package { 'forever':
      require => Package['npm'],
      ensure   => present,
      provider => 'npm',
  }
}
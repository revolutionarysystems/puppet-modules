class forever {
  package { 'forever':
      require => Package['npm'],
      ensure   => present,
      provider => 'npm',
  }
}
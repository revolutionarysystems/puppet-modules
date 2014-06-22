class mongodb {
  package { "mongodb":
    ensure => present,
    before => Service["mongodb"]
  }

  service { "mongodb":
    ensure => running,
    enable => true
  }
}
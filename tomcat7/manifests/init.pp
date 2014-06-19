class tomcat7 {
  package { "tomcat7":
    ensure => present,
    before => Service["tomcat7"]
  }

  service { "tomcat7":
    ensure => running,
    enable => true
  }
}
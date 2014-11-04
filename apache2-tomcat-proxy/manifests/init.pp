define apache2-tomcat-proxy (){
  package { "apache2":
    ensure => present,
    before => Service["apache2"]
  }

  service { "apache2":
    ensure => running,
    enable => true
  }
  
  file { "/etc/apache2/sites-enabled/000-default.conf":
    ensure => "present",
    content => template("apache2-tomcat-proxy/000-default.conf.erb"),
    notify => Service["apache2"]
  }
}
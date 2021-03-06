define apache2-tomcat-proxy (){
  package { "apache2":
    ensure => present,
    before => Service["apache2"]
  }

  service { "apache2":
    ensure => running,
    enable => true
  }
  
  file { "/etc/apache2/mods-enabled/proxy.load":
    ensure => link,
    target => "/etc/apache2/mods-available/proxy.load",
    notify => Service["apache2"]
  }
  
  file { "/etc/apache2/mods-enabled/proxy_http.load":
    ensure => link,
    target => "/etc/apache2/mods-available/proxy_http.load",
    notify => Service["apache2"]
  }
  
  file { "/etc/apache2/sites-available/000-default.conf":
    ensure => "present",
    content => template("apache2-tomcat-proxy/000-default.conf.erb"),
    notify => Service["apache2"]
  }
}
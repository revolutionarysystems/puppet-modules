define apache2-tomcat-proxy-ssl (){
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
  
  file { "/etc/apache2/mods-enabled/ssl.load":
    ensure => link,
    target => "/etc/apache2/mods-available/ssl.load",
    notify => Service["apache2"]
  }
  
  file { "/etc/apache2/mods-enabled/ssl.conf":
    ensure => link,
    target => "/etc/apache2/mods-available/ssl.conf",
    notify => Service["apache2"]
  }
  
  file { "/etc/apache2/mods-enabled/rewrite.load":
    ensure => link,
    target => "/etc/apache2/mods-available/rewrite.load",
    notify => Service["apache2"]
  }
  
  file { "/etc/apache2/mods-enabled/socache_shmcb.load":
    ensure => link,
    target => "/etc/apache2/mods-available/socache_shmcb.load",
    notify => Service["apache2"]
  }
  
  file { "/etc/apache2/sites-available/000-default.conf":
    ensure => "present",
    content => template("apache2-tomcat-proxy-ssl/000-default.conf.erb"),
    notify => Service["apache2"]
  }
}
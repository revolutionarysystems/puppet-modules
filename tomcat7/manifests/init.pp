define tomcat7 ($max_heap_size="512m", $permgen_size="32m", $max_permgen_size="64m"){
  package { "tomcat7":
    ensure => present,
    before => Service["tomcat7"]
  }

  service { "tomcat7":
    ensure => running,
    enable => true
  }
  
  file { "/etc/default/tomcat7":
    ensure => "present",
    content => template("tomcat7/tomcat7.erb"),
    notify => Service["tomcat7"]
  }
  
  file { '/opt/tomcat7webapps':
      ensure => 'link',
      target => '/var/lib/tomcat7/webapps'
    }
}
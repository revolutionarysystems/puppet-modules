class puppet-workspace {
  file {["/opt/puppet"]:
    ensure => "directory"
  }
}
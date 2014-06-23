class puppet-artifacts {
  include puppet-workspace
  file {["/opt/puppet/artifacts", "/opt/puppet/artifacts/tmp"]:
    ensure => "directory"
  }
}
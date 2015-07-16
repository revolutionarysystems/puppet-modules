class page-mirror-server ($version="LATEST", $db_type="memory", $db_host="localhost", $db_name="recordings", $db_table_recordings="recordings", $db_table_blacklist="blacklist", $cloud_identity="", $cloud_credential="", $asset_bucket="", $asset_check_interval="600000", $asset_error_check_interval="1200000", $asset_head_timeout="10000", $asset_timeout="20000", $asset_blacklist="[]", $asset_host_timeout_threshold="3", $asset_host_timeout_retry_period="3600000", $stream_name="recordings", $application_name="recordings", $region="us-east-1") {

  include forever
  
  haven-artifact::tar { "page-mirror-server.tar.gz": 
    url => "build.revsys.co.uk/haven-repository",
    artifactId => "page-mirror-server",
    version => $version,
    file => "page-mirror-server"
  }
  
  file { "/opt/page-mirror-server":
    require => Haven-Artifact::Tar["page-mirror-server.tar.gz"],
    ensure => "directory",
    recurse => true,
    mode => 755,
    purge => false,
    source => "/opt/puppet/artifacts/page-mirror-server",
    notify => Exec["restart-page-mirror-server"]
  }
  
  exec{ "restart-page-mirror-server":
    refreshonly => true,
    command => "ps -ef | grep page-mirror-server | grep -v grep | awk '{print \$2}' | xargs kill -9",
    path => ["/bin", "/usr/bin", "/usr/local/bin"]
  }
  
  file { "/opt/page-mirror-server/config.js":
    require => File["/opt/page-mirror-server"],
    ensure => "present",
    content => template("page-mirror-server/config.js.erb")
  }
  
  file { "/opt/page-mirror-server/aws.properties":
    require => File["/opt/page-mirror-server"],
    ensure => "present",
    content => template("page-mirror-server/aws.properties.erb")
  }
  
  exec { "run_page_mirror_server":
    require => File['/opt/page-mirror-server'],
    environment => ["AWS_ACCESS_KEY_ID=${cloud_identity}", "AWS_SECRET_ACCESS_KEY=${cloud_credential}"],
    cwd => "/opt/page-mirror-server",
    command => "forever start --uid page-mirror-server --minUptime 1000 --spinSleepTime 60000 -a ./node_modules/aws-kcl/bin/kcl-bootstrap -e -p aws.properties --java /usr/bin/java",
    onlyif => "forever list | grep page-mirror-server | wc -l | grep -q 0",
    path => ["/bin", "/usr/bin", "/usr/local/bin"]
  }
}
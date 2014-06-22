class haven-repository ($version="LATEST", $deployName="haven-repository"){
  class {"resource-repository":
    version => $version,
    deployName => $deployName
  }
}
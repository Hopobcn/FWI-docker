# FWI Dockerfiles

extends `hopobcn/pgi-ce:16.10-cuda8.0-devel-ubunu16.04`

branches:
* `master` only installs cmake
* `gtc2017` installs all software required for GTC2017-FWI lab [hopobcn/gtc2017-fwi](https://hub.docker.com/r/hopobcn/gtc2017-fwi)

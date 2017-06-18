#!/bin/bash

set -x

STATE=$1
SIFT_VERSION=${2:-stable}

docker run -it --rm --name="sift-package-${STATE}" -v `pwd`/sift:/srv/salt/sift sansdfir/sift-salt-tester /bin/bash



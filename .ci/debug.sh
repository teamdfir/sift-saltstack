#!/bin/bash

set -x

DISTRO=${DISTRO:="bionic"}
STATE=$1
SIFT_VERSION=${2:-stable}

docker run -it --rm --name="sift-package-${STATE}" -p 8080:80 -v `pwd`/sift:/srv/salt/sift teamdfir/sift-saltstack-tester:$DISTRO /bin/bash



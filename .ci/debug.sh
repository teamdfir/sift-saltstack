#!/bin/bash

set -x

DISTRO=${DISTRO:="focal"}
SALT=${SALT:="3005"}
STATE=$1
SIFT_VERSION=${2:-stable}

docker run -it --rm --name="sift-package-${STATE}" -p 8080:80 -v `pwd`/sift:/srv/salt/sift ghcr.io/teamdfir/sift-saltstack-tester:${SALT}-${DISTRO} /bin/bash



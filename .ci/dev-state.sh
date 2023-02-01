#!/bin/bash

set -x

DISTRO=${DISTRO:="focal"}
SALT=${SALT:="3005"}
STATE=$1

docker run -it --rm --name="sift-state-${STATE}" -p 8080:80 -v `pwd`/sift:/srv/salt/sift --cap-add SYS_ADMIN ghcr.io/teamdfir/sift-saltstack-tester:${SALT}-${DISTRO} \
  /bin/bash

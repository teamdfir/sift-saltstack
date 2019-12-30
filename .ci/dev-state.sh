#!/bin/bash

set -x

DISTRO=${DISTRO:="bionic"}
STATE=$1

docker run -it --rm --name="sift-state-${STATE}" -p 8080:80 -v `pwd`/sift:/srv/salt/sift --cap-add SYS_ADMIN teamdfir/sift-saltstack-tester:${DISTRO} \
  /bin/bash

#!/bin/bash

DISTRO=${DISTRO:="focal"}
STATE=$1

docker run -it --rm --name="sift-package-${STATE}" -v `pwd`/sift:/srv/salt/sift --cap-add SYS_ADMIN teamdfir/sift-saltstack-tester:$DISTRO /bin/bash

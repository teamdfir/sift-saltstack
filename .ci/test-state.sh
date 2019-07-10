#!/bin/bash

set -x

DISTRO=${DISTRO:="bionic"}
STATE=$1

docker run -it --rm --name="sift-state-${STATE}" -v `pwd`/sift:/srv/salt/sift --cap-add SYS_ADMIN teamdfir/sift-saltstack-tester:${DISTRO} \
  salt-call -l debug --local --retcode-passthrough --state-output=mixed state.sls ${STATE} pillar="{sift_user: root}"

#!/bin/bash

set -x

DISTRO=${DISTRO:="focal"}
SALT=${SALT:="3005"}
STATE=$1

docker run -it --rm --name="sift-state-${STATE}" -v `pwd`/sift:/srv/salt/sift --cap-add SYS_ADMIN ghcr.io/teamdfir/sift-saltstack-tester:${SALT}-${DISTRO} \
  salt-call -l debug --local --retcode-passthrough --state-output=mixed state.sls ${STATE} pillar="{sift_user: root}"

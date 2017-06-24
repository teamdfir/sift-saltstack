#!/bin/bash

set -x

STATE=$1
SIFT_VERSION=${2:-stable}

docker run -it --rm --name="sift-package-${STATE}" -v `pwd`/sift:/srv/salt/sift --cap-add SYS_ADMIN sansdfir/sift-salt-tester \
  salt-call -l debug --local --retcode-passthrough --state-output=mixed state.sls ${STATE} pillar="{sift_version: ${SIFT_VERSION}}"




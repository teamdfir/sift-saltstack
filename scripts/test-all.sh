#!/bin/bash

SIFT_VERSION=${1:-stable}

docker run -it --rm --name="sift-package-${STATE}" -v `pwd`/sift:/srv/salt/sift --cap-add SYS_ADMIN sansdfir/sift-salt-tester \
  salt-call -l info --local --retcode-passthrough --state-output=mixed state.sls sift.vm pillar="{sift_version: ${SIFT_VERSION}}"

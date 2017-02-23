#!/bin/bash

STATE=$1

docker run -it --rm --name="sift-package-${STATE}" -v `pwd`/sift:/srv/salt/sift sansdfir/sift-salt-tester \
  salt-call -l debug --local --retcode-passthrough --state-output=mixed state.sls ${STATE}




#!/bin/bash

docker run -it --rm --name="sift-salt-test-all" -v `pwd`/sift:/srv/salt/sift sansdfir/sift-salt-tester \
  salt-call --local --retcode-passthrough --state-output=mixed state.sls sift.vm

#!/bin/bash

STATE=$1

docker run -t --rm --name="sift-package-${STATE}" sift-salt-tester \
  salt-call --local --retcode-passthrough --state-output=mixed state.sls ${STATE}




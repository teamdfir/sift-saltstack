#!/bin/bash

for STATE in `ls sift/packages`; do
  docker run -t --rm --name="sift-package-$STATE" sift-salt-tester \
    bash -c "salt-call --local pillar.set sift_version dev && salt-call --local --retcode-passthrough --state-output=mixed state.sls sift.packages.`basename -s .sls ${STATE}` || exit 1"
done

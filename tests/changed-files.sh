#!/bin/bash

for FILE in `git diff-tree --no-commit-id --name-only -r ${TRAVIS_COMMIT} | grep "sift/"`; do
  STATE=$(echo $FILE | sed "s/.sls//g" | sed "s/\//./g")
  docker run -t --rm --name="sift-package-${STATE}" sift-salt-tester \
    salt-call --local --retcode-passthrough --state-output=mixed state.sls ${STATE} || exit 1
done




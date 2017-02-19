#!/bin/bash

echo "States To Test:"
echo "`git diff-tree --no-commit-id --name-only -r ${TRAVIS_COMMIT} | grep "sift/" | grep ".sls$" | grep -v "init.sls"`"

for FILE in `git diff-tree --no-commit-id --name-only -r ${TRAVIS_COMMIT} | grep "sift/" | grep ".sls$" | grep -v "init.sls"`; do
  STATE=$(echo $FILE | sed "s/.sls//g" | sed "s/\//./g")
  echo "Testing ${STATE}"
  docker run -t --rm --name="sift-package-${STATE}" -v `pwd`/sift:/srv/salt/sift sift-salt-tester \
    salt-call --local --retcode-passthrough --state-output=mixed state.sls ${STATE} || exit 1
done




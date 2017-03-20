#!/bin/bash

CHANGED_FILES=$(git diff-tree --no-commit-id --name-status -r ${TRAVIS_COMMIT} | grep -v "^D" | awk '{ print $2 }' | grep ".sls$" | grep -v "init.sls" | grep "sift/")

if [ "x${CHANGED_FILES}" == "x" ]; then
  echo "No Changes to States Files Found."
  exit 0
fi

echo "States To Test:"
echo "${CHANGED_FILES}"
echo ""

for FILE in $CHANGED_FILES; do
  STATE=$(echo $FILE | sed "s/.sls//g" | sed "s/\//./g")
  echo "Testing ${STATE}"
  docker run -t --rm -v `pwd`/sift:/srv/salt/sift sansdfir/sift-salt-tester \
    salt-call --local --retcode-passthrough --state-output=mixed state.sls ${STATE} || exit 1
done




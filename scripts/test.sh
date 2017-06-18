#!/bin/bash

set -x

if [ "x$TRAVIS_TAG" != "x" ]; then
  echo "Detected Event: Tag"
  echo " > TAG: ${TRAVIS_TAG}"
  echo ""
  ./test-all-publish.sh || exit 1
  exit 0
fi

if [ "$TRAVIS_EVENT_TYPE" != "cron" ]; then
  echo "Detected Event: Push or PR"
  echo ""
  ./changed-files.sh || exit 1
  exit 0
fi

if [ "$TRAVIS_EVENT_TYPE" = "cron" ]; then
  echo "Detected Event: CRON"
  echo ""
  ./tests/test-all.sh || exit 1
  exit 0
fi


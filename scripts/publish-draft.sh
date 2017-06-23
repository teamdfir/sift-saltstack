#!/bin/bash

set -x

if [ "x$TRAVIS_TAG" == "x" ]; then
  echo "TRAVIS_TAG not found!"
  exit 1
fi

echo "Getting Release ID"
RELEASE_ID=`curl -XGET -H "Authorization: token ${GITHUB_ACCESS_TOKEN}" -q https://api.github.com/repos/sans-dfir/sift-saltstack/releases/tags/${TRAVIS_TAG}" | jq .id`

echo "Setting Release ID to Pass"
curl -XPATCH -H "Authorization: token ${GITHUB_ACCESS_TOKEN}" -q https://api.github.com/repos/sans-dfir/sift-saltstack/releases/${RELEASE_ID} -d '{"draft": false}'

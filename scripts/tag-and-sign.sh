#!/bin/bash -x

set -x

if [ "x`which jq`" == "x" ]; then
  echo "jq is required to use this script"
  exit 10
fi

if [ $# -ne 1 ]; then
  echo "Usage: $0 TAG_NAME"
  exit 1
fi

if [ "x${GITHUB_ACCESS_TOKEN}" == "x" ]; then
  echo "GITHUB_ACCESS_TOKEN env var must be set for authentication"
  exit 5
fi

TAG_NAME=$1
PRERELEASE=false

`echo $TAG_NAME | grep -q "rc"`
if [ $? -eq 0 ]; then
  PRERELEASE="true"
fi

STASH_RESULTS=`git stash -u`

if [ "`cat VERSION`" != "${TAG_NAME}" ]; then
  echo "==> Updating Release Version"
  rm -f VERSION
  echo "$TAG_NAME" > VERSION
  git add VERSION
  git commit -m "Updating VERSION to $TAG_NAME"
  git push origin master

  echo "==> Tagging Repository"
  git tag $TAG_NAME

  echo "==> Pushing Tags to Remote"
  git push origin --tags

  echo "==> Sleeping, waiting for tag.gz file"
  sleep 3
fi

echo "==> Creating GitHub Release"
RELEASE_ID=`curl -XPOST -H "Authorization: token ${GITHUB_ACCESS_TOKEN}" -q https://api.github.com/repos/sans-dfir/sift-saltstack/releases -d "{\"tag_name\": \"$TAG_NAME\", \"prerelease\": $PRERELEASE}" | jq .id`

echo "==> Downloading tar.gz file for tag from GitHub"
curl -qL -o /tmp/sift-saltstack-${TAG_NAME}.tar.gz https://github.com/sans-dfir/sift-saltstack/archive/$TAG_NAME.tar.gz

echo "==> Generating SHA256 of tar.gz"
shasum -a 256 /tmp/sift-saltstack-$TAG_NAME.tar.gz > /tmp/sift-saltstack-$TAG_NAME.tar.gz.sha256

echo "==> Generating GPG Signature of SHA256"
gpg --armor --clearsign --digest-algo SHA256 -u 22598A94 /tmp/sift-saltstack-$TAG_NAME.tar.gz.sha256

echo "==> Generating GPG Signature of tar.gz file"
gpg --armor --detach-sign -u 22598A94 /tmp/sift-saltstack-$TAG_NAME.tar.gz

echo "==> Uploading sift-saltstack-$TAG_NAME.tar.gz.sha256"
curl -XPOST -H "Authorization: token ${GITHUB_ACCESS_TOKEN}" -H "Content-Type: text/plain" -q "https://uploads.github.com/repos/sans-dfir/sift-saltstack/releases/${RELEASE_ID}/assets?name=sift-saltstack-${TAG_NAME}.tar.gz.sha256" --data-binary @/tmp/sift-saltstack-$TAG_NAME.tar.gz.sha256

echo "==> Uploading sift-saltstack-$TAG_NAME.tar.gz.sha256.asc"
curl -XPOST -H "Authorization: token ${GITHUB_ACCESS_TOKEN}" -H "Content-Type: text/plain" -q "https://uploads.github.com/repos/sans-dfir/sift-saltstack/releases/${RELEASE_ID}/assets?name=sift-saltstack-${TAG_NAME}.tar.gz.sha256.asc" --data-binary @/tmp/sift-saltstack-$TAG_NAME.tar.gz.sha256.asc

echo "==> Uploading sift-saltstack-$TAG_NAME.tar.gz.asc"
curl -XPOST -H "Authorization: token ${GITHUB_ACCESS_TOKEN}" -H "Content-Type: text/plain" -q "https://uploads.github.com/repos/sans-dfir/sift-saltstack/releases/${RELEASE_ID}/assets?name=sift-saltstack-${TAG_NAME}.tar.gz.asc" --data-binary @/tmp/sift-saltstack-$TAG_NAME.tar.gz.asc

rm /tmp/sift-saltstack-${TAG_NAME}.tar.gz
rm /tmp/sift-saltstack-$TAG_NAME.tar.gz.sha256
rm /tmp/sift-saltstack-$TAG_NAME.tar.gz.sha256.asc
rm /tmp/sift-saltstack-$TAG_NAME.tar.gz.asc

if [ "${STASH_RESULTS}" != "No local changes to save" ]; then
  git stash pop
fi

#!/bin/bash

SIFT_VERSION=${1:-stable}

docker run -it --rm --name="sift-package-${STATE}" -v `pwd`/sift:/srv/salt/sift --cap-add SYS_ADMIN sift-saltstack:bionic /bin/bash

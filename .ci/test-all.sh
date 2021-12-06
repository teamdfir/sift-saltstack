#!/bin/bash

DISTRO=${DISTRO:="focal"}

docker run -it --rm --name="sift-test-all" -v "$(pwd):/srv/salt/sift" --cap-add SYS_ADMIN teamdfir/sift-saltstack-tester:${DISTRO} /bin/bash

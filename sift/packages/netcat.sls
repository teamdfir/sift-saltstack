# Name: netcat-openbsd
# Website: https://github.com/openbsd/src/tree/master/usr.bin/nc
# Description: OpenBSD rewrite of the original netcat
# Category: 
# Author: OpenBSD (see License for individual names)
# License: Multiple (https://git.launchpad.net/ubuntu/+source/netcat-openbsd/tree/debian/copyright)
# Notes: nc

sift-package-netcat-openbsd:
  pkg.installed:
    - name: netcat-openbsd

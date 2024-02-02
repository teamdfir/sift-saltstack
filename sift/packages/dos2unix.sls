# Name: dos2unix
# Website: https://waterlan.home.xs4all.nl/dos2unix.html
# Description: Convert text files with Windows or macOS line breaks to Unix line breaks and vise versa.
# Category: 
# Author: Benjamin Lin, Bernd Johannes Wuebben, Erwin Waterlander
# License: FreeBSD style license: https://waterlan.home.xs4all.nl/dos2unix/COPYING.txt
# Notes: dos2unix, mac2unix, unix2dos, unix2mac

sift-package-dos2unix:
  pkg.installed:
    - name: dos2unix

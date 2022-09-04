# Name: e2fslibs-dev
# Website: http://e2fsprogs.sourceforge.net/
# Description: File system utilities for use with the ext2 file system
# Category:
# Author: Theodore Ts'o
# License: GNU General Public License v2
# Notes:

{% if grains['oscodename'] != "jammy" %}

e2fslibs-dev:
  pkg.installed

{% else %}

e2fslib-dev-not-in-jammy:
  test.nop

{% endif %}

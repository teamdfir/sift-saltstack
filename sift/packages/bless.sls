# Name: bless
# Website: https://github.com/afrantzis/bless
# Description: Graphical Hex Editor
# Category: 
# Author: Alexandros Frantzis
# License: GNU General Public License v2.0 (https://github.com/afrantzis/bless/blob/master/COPYING)
# Notes: bless
# TODO: fix when package is available

{% if grains['oscodename'] != 'noble' %}
bless:
  pkg.installed
{% else %}
Bless is not available on Noble:
  test.nop
{% endif %}

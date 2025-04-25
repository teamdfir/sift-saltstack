# Name: cmospwd
# Website: https://www.cgsecurity.org/wiki/CmosPwd
# Description: Cross-platform tool to decrypt password stored in CMOS
# Category: 
# Author: Christophe Grenier
# License: GNU General Public License v2
# Notes: 

{% if grains['osarch'] == "amd64" %}

cmospwd:
  pkg.installed

{% else %}

cmospwd:
  test.nop:
    - name: "not-supported-on-arm64"

{% endif %}


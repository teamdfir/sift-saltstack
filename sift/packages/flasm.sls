# Name: flasm
# Website: https://www.nowrap.de/flasm.html
# Description: SWF dissassembler
# Category: 
# Author: Igor Kogan
# License: BSD License (https://www.nowrap.de/flasm.html#useterms)
# Notes: flasm

{% if grains['oscodename'] != "jammy" %}

sift-package-flasm:
  pkg.installed:
    - name: flasm

{% else %}

flasm-not-in-jammy:
  test.nop

{% endif %}

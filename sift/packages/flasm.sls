# Name: flasm
# Website: https://www.nowrap.de/flasm.html
# Description: SWF dissassembler
# Category: 
# Author: Igor Kogan
# License: BSD License (https://www.nowrap.de/flasm.html#useterms)
# Notes: flasm

{% if grains['oscodename'] != "jammy" %}

flasm:
  pkg.installed

{% else %}

flasm-not-in-jammy:
  test.nop

{% endif %}

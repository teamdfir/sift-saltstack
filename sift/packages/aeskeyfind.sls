# Name: AESKeyFinder
# Website: https://citp.princeton.edu/our-work/memory/
# Description: Find 128-bit and 256-bit AES keys in a memory image.
# Category: 
# Author: Nadia Heninger, Alex Halderman
# License: Free, unknown license
# Notes: aeskeyfind

{% if grains["osarch"] == "amd64" %}

aeskeyfind:
  pkg.installed

{% else %}

sift-package-aeskeyfind:
  test.nop:
    - name: "aeskeyfind-not-supported-on-arm64"

{%- endif -%}


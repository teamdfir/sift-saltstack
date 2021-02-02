# Name: magnus
# Website: https://github.com/stuartlangridge/magnus
# Description: Simple screen magnifier for Ubuntu 
# Category: 
# Author: Stuart Langridge, Martin Wimpress
# License: MIT License (https://github.com/stuartlangridge/magnus/blob/master/LICENSE)
# Notes: magnus

{%- if grains['oscodename'] == "bionic" %}
include:
  - sift.repos.flexiondotorg

magnus:
  pkg.installed:
    - require:
      - sls: sift.repos.flexiondotorg

{%- elif grains['oscodename'] == "focal" %}
magnus:
  pkg.installed

{%- endif -%}

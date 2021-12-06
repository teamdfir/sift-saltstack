# Name: arc-theme
# Website: http://ppa.launchpad.net/noobslab/icons/ubuntu/pool/main/
# Description: ARC-theme from the noobslab repo
# Category: 
# Author: https://github.com/horst3180/arc-theme/blob/master/AUTHORS
# License: GNU General Public License v3 (https://github.com/horst3180/arc-theme/blob/master/COPYING)
# Notes: 

{%- if grains['oscodename'] == "bionic" %}
include:
  - sift.repos.noobslab

sift-package-arc-theme:
  pkg.installed:
    - name: arc-theme
    - require:
      - pkgrepo: sift-repo-noobslab-themes
{%- else %}
sift-package-arc-theme:
  test.nop
{%- endif %}

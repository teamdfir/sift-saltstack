# Name: arc-icons
# Website: https://github.com/horst3180/arc-icon-theme
# Description: ARC-Icon set from the noobslab repo
# Category: 
# Author: https://github.com/horst3180/arc-icon-theme/blob/master/CREDITS
# License: GNU General Public License v3 (https://github.com/horst3180/arc-icon-theme/blob/master/COPYING)
# Notes: 
{%- if grains['oscodename'] == "bionic" %}
include:
  - sift.repos.noobslab

sift-package-arc-icons:
  pkg.installed:
    - name: arc-icons
    - require:
      - pkgrepo: sift-repo-noobslab-icons
{%- else %}
sift-package-arc-icons:
  test.nop
{%- endif %}

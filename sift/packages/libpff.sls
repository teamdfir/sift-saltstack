# Name: libpff
# Website: https://github.com/libyal/libpff
# Description: Library to access the Personal and Offline File Folder formats (PST / OST)
# Category:
# Author: Joachim Metz et al (https://github.com/libyal/libpff/blob/main/AUTHORS)
# License: GNU and GNU Lesser General Public License v3 (https://github.com/libyal/libpff/blob/main/COPYING)
# Notes: 

{% if grains['oscodename'] == 'jammy' %}
  {% set package = 'libpff1' %}
{% elif grains['oscodename'] == 'noble' %}
  {% set package = 'libpff1t64' %}
{% endif %}

sift-package-libpff1:
  pkg.installed:
    - name: {{ package }}


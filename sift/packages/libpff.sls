# Name: libpff
# Website: https://github.com/libyal/libpff
# Description: Library to access the Personal and Offline File Folder formats (PST / OST)
# Category:
# Author: Joachim Metz et al (https://github.com/libyal/libpff/blob/main/AUTHORS)
# License: GNU and GNU Lesser General Public License v3 (https://github.com/libyal/libpff/blob/main/COPYING)
# Notes: 

{% if grains['oscodename'] == 'jammy' %}

sift-package-libpff1:
  pkg.installed:
    - name: libpff1

{% elif grains['oscodename'] == 'noble' %}

sift-package-libpff1t64:
  pkg.installed:
    - name: libpff1t64

{% endif %}

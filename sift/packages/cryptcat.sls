# Name: cryptcat
# Website: http://cryptcat.sourceforge.net/
# Description: Netcat enhanced with encryption
# Category: 
# Author: http://cryptcat.sourceforge.net/credits.php
# License: GNU General Public License v2.0
# Notes: 
# TODO: fix when package available

{% if grains['oscodename'] != 'noble' %}
cryptcat:
  pkg.installed
{% else %}
Cryptcat is not available in Noble:
  test.nop
{% endif %}

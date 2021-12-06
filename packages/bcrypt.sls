# Name: bcrypt
# Website: http://bcrypt.sourceforge.net/index.html
# Description: Cross-platform file encryption tool
# Category: 
# Author: Johnny Shelley, Philip Stolarczyk
# License: Copyright (c) 2002 Johnny Shelley All rights reserved (bcrypt.sourceforge.net/index.html)
# Notes: 
{%- if grains['oscodename'] == "bionic" %}
sift-package-bcrypt:
  pkg.installed:
    - name: bcrypt
{%- else %}
sift-package-bcrypt:
  test.nop
{%- endif %}

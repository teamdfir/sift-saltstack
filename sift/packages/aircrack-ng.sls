# Name: aircrack-ng
# Website: https://www.aircrack-ng.org/
# Description: WiFi assessment tool suite
# Category: 
# Author: https://github.com/aircrack-ng/aircrack-ng/blob/master/AUTHORS
# License: https://www.aircrack-ng.org/license.html
# Notes: aircrack

{%- if grains["osarch"] == "amd64" -%}

aircrack-ng:
  pkg.installed

{%- else %}

aircrack-ng:
  test.nop:
    - name: "not-supported-on-arm"

{% endif %}


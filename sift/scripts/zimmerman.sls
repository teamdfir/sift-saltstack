# Name: Zimmerman Tools
# Website: https://ericzimmerman.github.io/#!index.md
# Description: A collection of Windows binaries to parse Windows artifacts, running with .NET
# Category: 
# Author: Eric Zimmerman
# License: MIT License
# Notes: amcacheparser, appcompatcacheparser, bstrings, evtxecmd, iisgeolocate, jlecmd, lecmd, mftecmd, rbcmd, recentfilecacheparser, recmd, rla, sbecmd, sqlecmd, wxtcmd

{% set tools = ['AmcacheParser','AppCompatCacheParser','bstrings','EvtxECmd','iisGeolocate','JLECmd','LECmd','MFTECmd','RBCmd','RecentFileCacheParser','RECmd','rla','SBECmd','SQLECmd','WxTCmd'] %}

include:
  - sift.packages.dotnet

{% for tool in tools %}
download-{{ tool }}:
  file.managed:
    - name: /tmp/{{ tool }}.zip
    - source: https://download.ericzimmermanstools.com/net6/{{ tool }}.zip
    - skip_verify: True
    - makedirs: True

extract-{{ tool }}:
  archive.extracted:
    - name: /opt/zimmermantools/
    - source: /tmp/{{ tool }}.zip
    - enforce_toplevel: false

{{ tool }}-wrapper:
  file.managed:
    - names:
      - /usr/local/bin/{{ tool }}
      - /usr/local/bin/{{ tool|lower }}
    - contents: |
        #!/bin/bash
        {% if tool|lower == "iisgeolocate" or tool|lower == "recmd" or tool|lower == "sqlecmd" %}
        dotnet /opt/zimmermantools/{{ tool }}/{{ tool }}.dll ${*}
        {% elif tool|lower == "evtxecmd" %}
        dotnet /opt/zimmermantools/EvtxeCmd/{{ tool }}.dll ${*}
        {% else %}
        dotnet /opt/zimmermantools/{{ tool }}.dll ${*}
        {% endif %}
    - mode: 755
    - replace: True

remove-{{ tool }}-zip:
  file.absent:
    - name: /tmp/{{ tool }}.zip
    - require:
      - file: {{ tool }}-wrapper
{% endfor %}

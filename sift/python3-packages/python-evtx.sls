# Name: python-evtx
# Website: https://github.com/williballenthin/python-evtx
# Description: Pure Python parser for Windows Event Log (.evtx) files
# Category:
# Author: Willi Ballenthin
# License: Apache License 2.0 (https://github.com/williballenthin/python-evtx/blob/master/LICENSE.TXT)
# Notes: evtx_dates.py, evtx_dump.py, evtx_dump_chunk_slack.py, evtx_dump_json.py, evtx_info.py

include:
  - sift.python3-packages.core
  - sift.packages.git

sift-python3-packages-python-evtx:
  pip.installed:
    - name: git+https://github.com/williballenthin/python-evtx.git
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.core
      - sls: sift.packages.git

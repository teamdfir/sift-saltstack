# Name: plaso
# Website: https://github.com/log2timeline/plaso
# Description: Python-based tool to create a timeline based on several sources
# Category: 
# Author: Joachim Metz
# License: Apache License 2.0 (https://github.com/log2timeline/plaso/blob/main/LICENSE)
# Notes: psteal.py, psort.py, log2timeline.py

include:
  - sift.repos.gift

sift-package-plaso-remove:
  pkg.removed:
    - names:
      - plaso-data
      - plaso-tools
      - plaso

sift-package-plaso-tools:
  pkg.latest:
    - name: plaso-tools
    - require:
      - sls: sift.repos.gift
      - pkg: sift-package-plaso-remove

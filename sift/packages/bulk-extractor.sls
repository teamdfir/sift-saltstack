# Name: bulk_extractor
# Website: https://github.com/simsong/bulk_extractor/
# Description: Extract interesting strings from binary files.
# Category:
# Author: https://github.com/simsong/bulk_extractor/blob/master/AUTHORS
# License: Portions Public Domain, portions MIT License: https://github.com/simsong/bulk_extractor/blob/master/LICENSE.md
# Notes: 

include:
  - sift.repos.sift
  - sift.repos.openjdk

sift-package-bulk-extractor:
  pkg.installed:
    - name: bulk-extractor
    - require:
      - pkgrepo: sift-repo
      - pkgrepo: openjdk-repo

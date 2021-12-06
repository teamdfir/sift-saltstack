# Name: bulk_extractor
# Website: https://github.com/simsong/bulk_extractor/
# Description: Extract interesting strings from binary files.
# Category:
# Author: https://github.com/simsong/bulk_extractor/blob/master/AUTHORS
# License: Portions Public Domain, portions MIT License: https://github.com/simsong/bulk_extractor/blob/master/LICENSE.md
# Notes: 

include:
  - ..repos.sift
  - ..repos.openjdk

bulk-extractor:
  pkg.installed:
    - require:
      - pkgrepo: sift-repo
      - pkgrepo: openjdk-repo

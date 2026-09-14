# Name: YARA
# Website: https://virustotal.github.io/yara/
# Description: Pattern-matching engine for identifying and classifying malware by rule.
# Category:
# Author: Victor M. Alvarez, VirusTotal
# License: BSD 3-Clause (https://github.com/VirusTotal/yara/blob/master/LICENSE)
# Notes: yara, yarac
#
# SIFT shipped the python3-yara bindings but never the command-line scanner, which several
# tools shell out to. See sift.packages.python3-yara for the module.

include:
  - sift.repos.ubuntu-universe

sift-package-yara:
  pkg.installed:
    - name: yara
    - require:
      - sls: sift.repos.ubuntu-universe

# Name: libewf
# Website: https://github.com/libyal/libewf-legacy
# Description: Expert Witness Compression Format (EWF/E01) library.
# Category:
# Author: Joachim Metz
# License: LGPLv3+
# Notes:
#
# The package is `libewf`, not `libewf2`. gift is authoritative for libyal (see AGENTS.md)
# and ships no libewf2 -- that name is Ubuntu's, and gift's libewf Conflicts/Replaces it.
# Repointing this at libewf2 removes sleuthkit, libtsk19, libewf and libewf-tools, because
# sift's sleuthkit declares `Depends: libewf`. Consolidated here from packages/libewf2.sls,
# a byte-identical duplicate that shared this state ID.

include:
  - sift.repos.gift

sift-package-libewf:
  pkg.installed:
    - name: libewf
    - require:
      - sls: sift.repos.gift

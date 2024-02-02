# Name: ClamAV
# Website: https://www.clamav.net
# Description: Scan files for malware signatures.
# Category: 
# Author: https://www.clamav.net/about
# License: GNU General Public License (GPL): https://www.clamav.net/about
# Notes: clamscan, freshclam

sift-package-clamav:
  pkg.installed:
    - name: clamav

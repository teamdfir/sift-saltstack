# Name: PowerShell
# Website: https://microsoft.com/powershell
# Description: Linux package for PowerShell
# Category:
# Author: Microsoft
# License: MIT License (https://github.com/PowerShell/PowerShell/blob/master/LICENSE.txt)
# Notes: pwsh

include:
  - sift.repos.microsoft
  - sift.packages.libicu

sift-package-powershell:
  pkg.installed:
    - name: powershell
    - require:
      - sls: sift.repos.microsoft
      - sls: sift.packages.libicu
    - onlyif:
      - fun: match.grain
        tgt: 'osarch:amd64'

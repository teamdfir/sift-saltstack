{%- set remove_plugins = ["malprocfind.py","idxparser.py","chromehistory.py","mimikatz.py","openioc_scan.py","pstotal.py","firefoxhistory.py","autoruns.py","malfinddeep.py","prefetch.py","ssdeepscan.py","uninstallinfo.py","trustrecords.py","usnparser.py","apihooksdeep.py","editbox.py","javarat.py"] -%}

# Name: Volatility Framework
# Website: https://github.com/volatilityfoundation/volatility
# Description: Memory forensics tool and framework
# Category: Perform Memory Forensics
# Author: https://github.com/volatilityfoundation/volatility/blob/2.6.1/AUTHORS.txt
# License: GNU General Public License (GPL) v2: https://github.com/volatilityfoundation/volatility/blob/2.6.1/LICENSE.txt
# Notes: Use vol.py to invoke this version of Volatility. To eliminate conflicts among command-line options for Volatility plugins, the following `yarascan` options have been changed: `-Y` became `-U` and `-C` became `-c`.

include:
  - sift.packages.git
  - sift.packages.python3
  - sift.packages.python3-virtualenv

sift-app-volatility-virtual-env:
  virtualenv.managed:
    - name: /opt/volatility
    - system_site_packages: False
    - requirements: salt://sift/apps/volatility/requirements.txt
    - require:
      - sls: sift.packages.python3
      - sls: sift.packages.python3-virtualenv

sift-app-volatility:
  pip.installed:
    - name: git+https://github.com/volatilityfoundation/volatility.git@master
    - bin_env: /opt/volatility/bin/python
    - upgrade: True
    - require:
      - sls: sift.packages.git
      - virtualenv: sift-app-volatility-virtual-env

sift-app-volatility-symlink:
  file.symlink:
    - name: /usr/local/bin/vol
    - target: /opt/volatility/bin/vol.py
    - force: True
    - require:
      - pip: sift-app-volatility

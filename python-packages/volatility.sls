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
  - sift.packages.python3-pip
  - sift.packages.python2-pip
  - sift.python-packages.colorama
  - sift.python-packages.construct
  - sift.python-packages.dpapick
  - sift.python-packages.distorm3
  - sift.python-packages.ioc_writer
  - sift.python-packages.lxml
  - sift.python-packages.openpyxl
  - sift.python-packages.pefile
  - sift.python-packages.pillow
  - sift.python-packages.pycoin
  - sift.python-packages.pycrypto
  - sift.python-packages.pysocks
  - sift.python-packages.requests
  - sift.python-packages.simplejson
  - sift.python-packages.yara-python

sift-python-packages-volatility:
  pip.installed:
    - name: git+https://github.com/volatilityfoundation/volatility.git@master
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python2-pip

sift-python-volatility-community-plugins:
  git.latest:
    - name: https://github.com/sans-dfir/volatility-plugins-community.git
    # Note: This path changed to /usr/local/lib starting in 18.04
    - target: /usr/local/lib/python2.7/dist-packages/volatility/plugins/community
    - user: root
    - branch: master
    - force_fetch: True
    - force_checkout: True
    - force_clone: True
    - force_reset: True
    - require:
      - sls: sift.packages.git
      - pip: sift-python-packages-volatility
      - sls: sift.python-packages.colorama
      - sls: sift.python-packages.construct
      - sls: sift.python-packages.dpapick
      - sls: sift.python-packages.distorm3
      - sls: sift.python-packages.ioc_writer
      - sls: sift.python-packages.lxml
      - sls: sift.python-packages.openpyxl
      - sls: sift.python-packages.pefile
      - sls: sift.python-packages.pillow
      - sls: sift.python-packages.pycoin
      - sls: sift.python-packages.pycrypto
      - sls: sift.python-packages.pysocks
      - sls: sift.python-packages.requests
      - sls: sift.python-packages.simplejson
      - sls: sift.python-packages.yara-python

sift-python-volatility-sift-plugins:
  file.recurse:
    # Note: This path changed to /usr/local/lib starting in 18.04
    - name: /usr/local/lib/python2.7/dist-packages/volatility/plugins/sift/
    - source: salt://sift/files/volatility
    - makedirs: True
    - file_mode: 644
    - include_pat: '*.py'
    - watch:
      - git: sift-python-volatility-community-plugins
      - pip: sift-python-packages-volatility

{% for plugin in remove_plugins -%}
sift-python-volatility-plugins-{{ plugin }}-absent:
  file.absent:
    # Note: This path changed to /usr/local/lib starting in 18.04
    - name: /usr/local/lib/python2.7/dist-packages/volatility/plugins/{{ plugin }}
    - watch:
      - git: sift-python-volatility-community-plugins
      - pip: sift-python-packages-volatility
{% endfor -%}

sift-python-volatility-mimikatz-plugin-update:
  file.managed:
    - name: /usr/local/lib/python2.7/dist-packages/volatility/plugins/community/FrancescoPicasso/mimikatz.py
    - source: https://github.com/RealityNet/hotoloti/raw/master/volatility/mimikatz.py
    - source_hash: sha256=75e2e6d3b09daffad83211ba0215ed3f204623b8c37c2a2950665b88a3d2ce86
    - mode: 644
    - watch:
      - git: sift-python-volatility-community-plugins
      - pip: sift-python-packages-volatility

sift-python-packages-volatility-malfind-yarascan-options1:
  file.replace:
    - name: /usr/local/lib/python2.7/dist-packages/volatility/plugins/malware/malfind.py
    - pattern: short_option = 'C'
    - repl: short_option = 'c'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - git: sift-python-volatility-community-plugins

sift-python-packages-volatility-malfind-yarascan-options2:
  file.replace:
    - name: /usr/local/lib/python2.7/dist-packages/volatility/plugins/malware/malfind.py
    - pattern: short_option = 'Y'
    - repl: short_option = 'U'
    - prepend_if_not_found: False
    - count: 1
    - require:
      - file: sift-python-packages-volatility-malfind-yarascan-options1

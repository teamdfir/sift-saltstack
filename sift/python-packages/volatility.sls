{%- set remove_plugins = ["malprocfind.py","idxparser.py","chromehistory.py","mimikatz.py","openioc_scan.py","pstotal.py","firefoxhistory.py","autoruns.py","malfinddeep.py","prefetch.py","ssdeepscan.py","uninstallinfo.py","trustrecords.py","usnparser.py","apihooksdeep.py","editbox.py","javarat.py"] -%}

include:
  - sift.repos.sift
  - sift.packages.git
  - sift.packages.python3-pip
  - sift.python-packages.colorama
  - sift.python-packages.construct
  - sift.python-packages.dpapick
  - sift.python-packages.distorm3
  - sift.python-packages.haystack
  - sift.python-packages.ioc_writer
  - sift.python-packages.lxml
  - sift.python-packages.pefile
  - sift.python-packages.pycoin
  - sift.python-packages.pysocks
  - sift.python-packages.simplejson
  - sift.python-packages.yara-python

sift-python-volatility:
  pip.installed:
    - name: git+https://github.com/volatilityfoundation/volatility.git@2.6.1
    - require:
      - sls: sift.packages.git
      - sls: sift.packages.python3-pip

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
      - pip: sift-python-volatility
      - sls: sift.packages.git
      - sls: sift.python-packages.colorama
      - sls: sift.python-packages.construct
      - sls: sift.python-packages.dpapick
      - sls: sift.python-packages.distorm3
      - sls: sift.python-packages.haystack
      - sls: sift.python-packages.ioc_writer
      - sls: sift.python-packages.lxml
      - sls: sift.python-packages.pefile
      - sls: sift.python-packages.pycoin
      - sls: sift.python-packages.pysocks
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
      - pip: sift-python-volatility

{% for plugin in remove_plugins -%}
sift-python-volatility-plugins-{{ plugin }}-absent:
  file.absent:
    # Note: This path changed to /usr/local/lib starting in 18.04
    - name: /usr/local/lib/python2.7/dist-packages/volatility/plugins/{{ plugin }}
    - watch:
      - git: sift-python-volatility-community-plugins
      - pip: sift-python-volatility
{% endfor -%}
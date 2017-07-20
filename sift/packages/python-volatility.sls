{%- set remove_plugins = ["malprocfind.py","idxparser.py","chromehistory.py","mimikatz.py","openioc_scan.py","pstotal.py","firefoxhistory.py","autoruns.py","malfinddeep.py","prefetch.py","baseline.py","ssdeepscan.py","uninstallinfo.py","trustrecords.py","usnparser.py","apihooksdeep.py","editbox.py","javarat.py"] -%}

include:
  - ..repos.sift
  - .git
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

python-volatility:
  pkg.installed:
    - name: python-volatility
    - require:
      - pkgrepo: sift-repo

python-volatility-community-plugins:
  git.latest:
    - name: https://github.com/sans-dfir/volatility-plugins-community.git
    - target: /usr/lib/python2.7/dist-packages/volatility/plugins/community
    - user: root
    - rev: master
    - force_clone: True
    - require:
      - pkg: git
      - pkg: python-volatility
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

python-volatility-sift-plugins:
  file.recurse:
    - name: /usr/lib/python2.7/dist-packages/volatility/plugins/sift/
    - source: salt://sift/files/volatility
    - makedirs: True
    - file_mode: 644
    - include_pat: '*.py'
    - watch:
      - pkg: python-volatility

{% for plugin in remove_plugins -%}
python-volatility-plugins-{{ plugin }}-absent:
  file.absent:
    - name: /usr/lib/python2.7/dist-packages/volatility/plugins/{{ plugin }}
    - watch:
      - pkg: python-volatility
{% endfor -%}

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
      - pkgrepo: sift

python-volatility-community-plugins:
  git.latest:
    - name: https://github.com/volatilityfoundation/community.git
    - target: /usr/lib/python2.7/dist-packages/volatility/plugins/community
    - user: root
    - rev: master
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

# Unable to install pykd
python-volatility-remove-AlexanderTarasenko:
  file.absent:
    - name: /usr/lib/python2.7/dist-packages/volatility/plugins/community/AlexanderTarasenko
    - watch:
      - git: python-volatility-community-plugins

# Conflicts with ThomasWhite Bitlocker 
python-volatility-remove-MarcinUlikowski:
  file.absent:
    - name: /usr/lib/python2.7/dist-packages/volatility/plugins/community/MarcinUlikowski
    - watch:
      - git: python-volatility-community-plugins


python-volatility-sift-plugins:
  file.recurse:
    - name: /usr/lib/python2.7/dist-packages/volatility/plugins/sift/
    - source: salt://sift/files/volatility
    - makedirs: True
    - file_mode: 644
    - include_pat: '*.py'
    - watch:
      - pkg: python-volatility

python-volatility-plugins-javarat-absent:
  file.absent:
    - name: /usr/lib/python2.7/dist-packages/volatility/plugins/javarat.py
    - watch:
      - pkg: python-volatility

python-volatility-plugins-editbox-absent:
  file.absent:
    - name: /usr/lib/python2.7/dist-packages/volatility/plugins/editbox.py
    - watch:
      - pkg: python-volatility

# Note: not included in init.sls, only required by python-volatility

include:
  - ..packages.python-pip

yara:
  pip.installed:
    - name: yara
    - upgrade: True
    - require:
      - pkg: python-pip

yara-lib-symlink:
  file.symlink:
    - name: /usr/lib/libyara.so
    - target: /usr/local/lib/python2.7/dist-packages/usr/lib/libyara.so
    - watch:
      - pip: yara

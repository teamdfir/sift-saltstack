include:
  - sift.packages.python-pip

distorm3:
  pip.installed:
    - name: distorm3 == 3.4.4
    - bin_env: /usr/bin/python
    - require:
      - pkg: python-pip

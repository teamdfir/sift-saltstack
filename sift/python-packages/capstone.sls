include:
  - sift.packages.python3-pip
  - sift.packages.python2-pip

sift-python-packages-pkg-remove:
  pkg.removed:
    - name: python-capstone

sift-python-packages-capstone:
  pip.installed:
    - name: capstone
    - bin_env: /usr/bin/python2
    - upgrade: True
    - require:
      - sls: sift.packages.python2-pip
      - pkg: sift-python-packages-pkg-remove

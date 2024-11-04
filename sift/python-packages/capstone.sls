include:
  - sift.packages.python2-pip
  - sift.packages.build-essential

sift-python-packages-pkg-remove:
  pkg.removed:
    - name: python-capstone

sift-python-packages-capstone:
  pip.installed:
    - name: capstone
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip
      - sls: sift.packages.build-essential
      - pkg: sift-python-packages-pkg-remove

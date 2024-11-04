include:
  - sift.packages.python2-pip

sift-python-packages-poster:
  pip.installed:
    - name: poster
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip

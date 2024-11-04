include:
  - sift.packages.python2-pip

sift-python-packages-pillow:
  pip.installed:
    - name: pillow
    - bin_env: /usr/bin/python2
    - require:
      - sls: sift.packages.python2-pip

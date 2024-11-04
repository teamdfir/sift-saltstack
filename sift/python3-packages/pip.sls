include:
  - sift.packages.python3-pip

sift-python3-packages-pip:
  pip.installed:
    - name: pip
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.packages.python3-pip

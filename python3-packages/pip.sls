include:
  - sift.packages.python3-pip

sift-python3-packages-pip:
  pip.installed:
    - name: pip==21.0.1
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.packages.python3-pip

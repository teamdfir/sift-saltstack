include:
  - sift.packages.python3-pip

sift-python3-packages-keyrings-alt:
  pip.installed:
    - name: keyrings.alt
    - bin_env: /usr/bin/python3
    - upgrade: True
    - require:
      - sls: sift.packages.python3-pip

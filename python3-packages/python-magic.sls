include:
  - sift.python3-packages.pip

sift-python3-packages-python-magic:
  pip.installed:
    - name: python-magic
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.pip

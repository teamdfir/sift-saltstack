include:
  - sift.python3-packages.pip

sift-python3-packages-python-registry:
  pip.installed:
    - name: python-registry
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.pip

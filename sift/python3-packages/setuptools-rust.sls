include:
  - sift.python3-packages.pip

sift-python3-packages-setuptools-rust:
  pip.installed:
    - name: setuptools_rust
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.pip

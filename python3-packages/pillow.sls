include:
  - sift.python3-packages.pip

sift-python3-packages-pillow:
  pip.installed:
    - name: pillow
    - bin_env: /usr/bin/python3
    - require:
      - sls: sift.python3-packages.pip

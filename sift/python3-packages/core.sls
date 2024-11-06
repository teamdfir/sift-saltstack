include:
  - sift.python3-packages.pip
  - sift.python3-packages.wheel
  - sift.python3-packages.setuptools

sift-python3-packages-core:
  test.nop:
    - name: python3-packages-core
    - require:
        - sls: sift.python3-packages.pip
        - sls: sift.python3-packages.wheel
        - sls: sift.python3-packages.setuptools

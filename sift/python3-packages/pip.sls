include:
  - sift.packages.python3-pip

sift-python3-packages-pip:
  cmd.run:
    - names:
      - /usr/bin/python3 -m pip install --upgrade pip
      - /usr/bin/python3 -m pip install setuptools==70.0.0
      - /usr/bin/python3 -m pip install --upgrade wheel
    - require:
      - sls: sift.packages.python3-pip

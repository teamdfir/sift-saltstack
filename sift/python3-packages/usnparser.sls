include:
  - sift.packages.python3-virtualenv

sift-python3-package-usnparser-venv:
  virtualenv.managed:
    - name: /opt/usnparser
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-usnparser:
  pip.installed:
    - name: git+https://github.com/digitalsleuth/USN-Journal-Parser.git
    - bin_env: /opt/usnparser/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-usnparser-venv

sift-python3-package-usnparser-symlink:
  file.symlink:
    - name: /usr/local/bin/usnparser
    - target: /opt/usnparser/bin/usn.py
    - makedirs: False
    - require:
      - pip: sift-python3-package-usnparser

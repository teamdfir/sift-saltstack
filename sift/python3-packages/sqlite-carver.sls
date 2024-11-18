include:
  - sift.packages.python3-virtualenv

sift-python3-package-sqlite-carver-venv:
  virtualenv.managed:
    - name: /opt/sqlite-carver
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-sqlite-carver:
  pip.installed:
    - name: sqlite-carver
    - bin_env: /opt/sqlite-carver/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-sqlite-carver-venv

sift-python3-package-sqlite-carver-symlink:
  file.symlink:
    - name: /usr/local/bin/sqlite-carver
    - target: /opt/sqlite-carver/bin/sqlite-carver
    - makedirs: False
    - require:
      - pip: sift-python3-package-sqlite-carver

include:
  - sift.packages.python3-virtualenv

sift-python3-package-analyzemft-virtualenv:
  virtualenv.managed:
    - name: /opt/analyzemft
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-analyzemft:
  pip.installed:
    - name: analyzeMFT
    - bin_env: /opt/analyzemft/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-analyzemft-virtualenv

sift-python3-package-analyzemft-symlink:
  file.symlink:
    - name: /usr/local/bin/analyzemft
    - target: /opt/analyzemft/bin/analyzemft
    - makedirs: False
    - require:
      - pip: sift-python3-package-analyzemft

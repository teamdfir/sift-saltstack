# source=https://github.com/digitalsleuth/pe-scanner
# license=gplv3.0

include:
  - sift.packages.python3-virtualenv
  - sift.packages.git
  - sift.packages.python3-magic

sift-python3-package-pe-scanner-venv:
  virtualenv.managed:
    - name: /opt/pe-scanner
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-pe-scanner:
  pip.installed:
    - name: git+https://github.com/digitalsleuth/pe-scanner.git
    - bin_env: /opt/pe-scanner/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-pe-scanner-venv
      - sls: sift.packages.git
      - sls: sift.packages.python3-magic

sift-python3-package-pe-scanner-symlink:
  file.symlink:
    - name: /usr/local/bin/pe-scanner
    - target: /opt/pe-scanner/bin/pe-scanner
    - makedirs: False
    - require:
      - pip: sift-python3-package-pe-scanner

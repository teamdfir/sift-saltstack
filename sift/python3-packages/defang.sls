# WEBSITE: https://github.com/HurricaneLabs/machinae
# LICENSE: MIT
include:
  - sift.packages.python3-virtualenv

sift-python3-package-defang-venv:
  virtualenv.managed:
    - name: /opt/defang
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-defang:
  pip.installed:
    - name: defang
    - bin_env: /opt/defang/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-defang-venv

sift-python3-package-defang-symlink:
  file.symlink:
    - name: /usr/local/bin/defang
    - target: /opt/defang/bin/defang
    - makedirs: False
    - require:
      - pip: sift-python3-package-defang

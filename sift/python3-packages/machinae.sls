# WEBSITE: https://github.com/HurricaneLabs/machinae
# LICENSE: MIT

include:
  - sift.packages.python3-virtualenv

sift-python3-package-machinae-venv:
  virtualenv.managed:
    - name: /opt/machinae
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - defang
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-machinae:
  pip.installed:
    - name: machinae
    - bin_env: /opt/machinae/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-machinae-venv

sift-python3-package-machinae-symlink:
  file.symlink:
    - name: /usr/local/bin/machinae
    - target: /opt/machinae/bin/machinae
    - makedirs: False
    - require:
      - pip: sift-python3-package-machinae

sift-python3-package-machine-config:
  file.managed:
    - name: /etc/machinae.yml
    - source: https://raw.githubusercontent.com/HurricaneLabs/machinae/refs/heads/master/machinae.yml
    - skip_verify: True
    - require:
      - file: sift-python3-package-machinae-symlink

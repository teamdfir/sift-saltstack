include:
  - sift.packages.python3-virtualenv

sift-python3-package-windowsprefetch-venv:
  virtualenv.managed:
    - name: /opt/windowsprefetch
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-windowsprefetch:
  pip.installed:
    - name: windowsprefetch
    - bin_env: /opt/windowsprefetch/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-windowsprefetch-venv

sift-python3-package-windowsprefetch-symlink:
  file.symlink:
    - name: /usr/local/bin/prefetch.py
    - target: /opt/windowsprefetch/bin/prefetch.py
    - makedirs: False
    - require:
      - pip: sift-python3-package-windowsprefetch

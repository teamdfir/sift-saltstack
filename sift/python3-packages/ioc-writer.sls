include:
  - sift.packages.python3-virtualenv
  - sift.packages.libxml2-dev
  - sift.packages.libxslt-dev

sift-python3-package-ioc-writer-venv:
  virtualenv.managed:
    - name: /opt/ioc_writer
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - lxml
    - require:
      - sls: sift.packages.python3-virtualenv
      - sls: sift.packages.libxml2-dev
      - sls: sift.packages.libxslt-dev

sift-python3-package-ioc-writer:
  pip.installed:
    - name: ioc_writer
    - bin_env: /opt/ioc_writer/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-ioc-writer-venv

sift-python3-package-ioc-writer-symlink:
  file.symlink:
    - name: /usr/local/bin/ioc_writer
    - target: /opt/ioc_writer/bin/ioc_writer
    - makedirs: False
    - require:
      - pip: sift-python3-package-ioc-writer

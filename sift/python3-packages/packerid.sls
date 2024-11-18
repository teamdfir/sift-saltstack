# source=https://github.com/sooshie/packerid
# license=Unknown

{% set commit = "bc54e6d5204ebe83db8d87125d677035d9f456a7" -%}
{% set hash = "sha256=417830ccbf357e8e2b7d9cf47ee4a63a481151fc8cdf03c40b5538aecf96d15d" -%}

include:
  - sift.packages.python3-virtualenv

sift-python3-package-packerid-venv:
  virtualenv.managed:
    - name: /opt/packerid
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - pefile
      - capstone
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-packerid:
  file.managed:
    - name: /opt/packerid/bin/packerid.py
    - source: https://raw.githubusercontent.com/sooshie/packerid/{{ commit }}/packerid.py
    - source_hash: {{ hash }}
    - mode: 755
    - require:
      - virtualenv: sift-python3-package-packerid-venv

sift-python3-package-packerid-shebang:
  file.replace:
    - name: /opt/packerid/bin/packerid.py
    - pattern: '#!/usr/local/bin/python'
    - repl: '#!/opt/packerid/bin/python3'
    - count: 1
    - watch:
      - file: sift-python3-package-packerid

sift-python3-package-packerid-symlink:
  file.symlink:
    - name: /usr/local/bin/packerid.py
    - target: /opt/packerid/bin/packerid.py
    - makedirs: False
    - require:
      - file: sift-python3-package-packerid


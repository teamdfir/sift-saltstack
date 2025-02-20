# Name: hindsight
# Website: https://github.com/obsidianforensics/hindsight
# Description: Web browser forensics for Google Chrome / Chromium
# Category: 
# Author: Ryan Benson (obsidianforensics)
# License: Apache License v2 (https://github.com/obsidianforensics/hindsight/blob/main/LICENSE.md)
# Notes: hindsight.py, hindsight_gui.py

{% set files = ['hindsight.py','hindsight_gui.py'] %}

include:
  - sift.packages.python3-virtualenv

sift-python3-package-pyhindsight-venv:
  virtualenv.managed:
    - name: /opt/pyhindsight
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - setuptools_rust
      - keyrings.alt
      - git+https://github.com/cclgroupltd/ccl_chromium_reader.git
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-pyhindsight:
  pip.installed:
    - name: pyhindsight
    - bin_env: /opt/pyhindsight/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-pyhindsight-venv

{% for file in files %}
sift-python3-package-pyhindsight-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}
    - target: /opt/pyhindsight/bin/{{ file }}
    - makedirs: False
    - require:
      - pip: sift-python3-package-pyhindsight

sift-python3-package-pyhindsight-chmod-{{ file }}:
  file.managed:
    - name: /opt/pyhindsight/bin/{{ file }}
    - mode: 755
    - require:
      - file: sift-python3-package-pyhindsight-symlink-{{ file }}
{% endfor %}

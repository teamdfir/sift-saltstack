# Name: Volatility3
# Website: https://github.com/volatilityfoundation/volatility3
# Description: Memory analysis toolset
# Category:
# Author: Volatility Foundation
# License: Volatility Software License (https://www.volatilityfoundation.org/license/vsl-v1.0)
# Notes: vol, volshell

{% set files = ['vol','volshell'] %}

include:
  - sift.packages.python3-virtualenv

sift-python3-package-volatility3-venv:
  virtualenv.managed:
    - name: /opt/volatility3
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-volatility3:
  pip.installed:
    - name: volatility3
    - bin_env: /opt/volatility3/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-volatility3-venv

{% for file in files %}
sift-python3-package-volatility3-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}
    - target: /opt/volatility3/bin/{{ file }}
    - force: True
    - makedirs: False
    - require:
      - pip: sift-python3-package-volatility3
{% endfor %}

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
      - yara-python>=4.5.1,<5
      - pycryptodome>=3.21.0,<4
      - capstone>=5.0.3,<6
      - leechcorepyc>=2.19.2,<3
      - pillow>=10.0.0,<11.0.0
      - pefile>=2024.8.26
      - yara-x
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

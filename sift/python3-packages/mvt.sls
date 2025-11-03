# Name: mvt
# Website: https://docs.mvt.re/en/latest/
# Description: Mobile Device analysis tool for Android and iOS devices
# Category: Mobile
# Author: Amnesty International
# License: MVT License (https://github.com/mvt-project/mvt/blob/main/LICENSE)
# Notes: mvt-android, mvt-ios

{% set tools = ['mvt-android','mvt-ios'] %}

include:
  - sift.packages.python3-virtualenv

sift-python3-package-mvt-virtualenv:
  virtualenv.managed:
    - name: /opt/mvt
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-mvt:
  pip.installed:
    - name: mvt
    - bin_env: /opt/mvt/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-mvt-virtualenv

{% for tool in tools %}
sift-python3-package-mvt-symlink-{{ tool }}:
  file.symlink:
    - name: /usr/local/bin/{{ tool }}
    - target: /opt/mvt/bin/{{ tool }}
    - makedirs: False
    - force: True
    - require:
      - pip: sift-python3-package-mvt
{% endfor %}

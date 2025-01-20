# Name: ioc_writer
# Website: https://github.com/mandiant/ioc_writer/
# Description: Tool to write and edit IOC objects
# Category:
# Author: William Gibb
# License: Apache License 2.0 (https://github.com/mandiant/ioc_writer/blob/master/LICENSE)
# Notes: iocdump, openioc_10_to_11, openioc_11_to_10

{% set files = ['iocdump','openioc_10_to_11','openioc_11_to_10'] %}

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
      - yara-python
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

{% for file in files %}
sift-python3-package-ioc-writer-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}
    - target: /opt/ioc_writer/bin/{{ file }}
    - makedirs: False
    - require:
      - pip: sift-python3-package-ioc-writer
{% endfor %}

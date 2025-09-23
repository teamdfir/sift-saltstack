# Name: python-evtx
# Website: https://github.com/williballenthin/python-evtx
# Description: Pure Python parser for Windows Event Log (.evtx) files
# Category:
# Author: Willi Ballenthin
# License: Apache License 2.0 (https://github.com/williballenthin/python-evtx/blob/master/LICENSE.TXT)
# Notes: evtx_dump.py, evtx_dump_chunk_slack.py, evtx_dump_json.py, evtx_eid_record_numbers.py, evtx_extract_record.py, evtx_filter_records.py, evtx_info.py, evtx_record_structure.py, evtx_structure.py, evtx_templates.py

{% set files = ['evtx_dump','evtx_dump_chunk_slack','evtx_dump_json','evtx_eid_record_numbers','evtx_extract_record','evtx_filter_records','evtx_info','evtx_record_structure','evtx_structure','evtx_templates'] %}
{% set commit = '1a1357accd3a75524794a6d6dcdec03c09e1660d' %}
{% if grains['oscodename'] == 'noble' %}
  {% set py_ver = '3.12' %}
{% elif grains['oscodename'] == 'jammy' %}
  {% set py_ver = '3.10' %}
{% endif %}

include:
  - sift.packages.python3-virtualenv
  - sift.packages.git

sift-python3-package-python-evtx-venv:
  virtualenv.managed:
    - name: /opt/python-evtx
    - venv_bin: /usr/bin/virtualenv
    - pip_pkgs:
      - pip>=24.1.3
      - setuptools>=70.0.0
      - wheel>=0.38.4
      - xmltodict
      - lxml
    - require:
      - sls: sift.packages.python3-virtualenv

sift-python3-package-python-evtx:
  pip.installed:
    - name: git+https://github.com/williballenthin/python-evtx.git@{{ commit }}
    - bin_env: /opt/python-evtx/bin/python3
    - upgrade: True
    - require:
      - virtualenv: sift-python3-package-python-evtx-venv
      - sls: sift.packages.git

sift-python3-package-python-evtx-import-fix:
  file.replace:
    - name: /opt/python-evtx/lib/python{{ py_ver }}/site-packages/evtx_scripts/evtx_eid_record_numbers.py
    - pattern: 'from filter_records'
    - repl: 'from evtx_scripts.evtx_filter_records'
    - count: 1
    - require:
      - pip: sift-python3-package-python-evtx

{% for file in files %}
sift-python3-package-python-evtx-symlink-{{ file }}:
  file.symlink:
    - name: /usr/local/bin/{{ file }}.py
    - target: /opt/python-evtx/bin/{{ file }}
    - makedirs: False
    - require:
      - pip: sift-python3-package-python-evtx
{% endfor %}

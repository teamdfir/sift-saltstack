{% set package_name = salt['grains.filter_by']({
  'xenial': 'python-dfvfs',
  'bionic': 'python-dfvfs',
  'focal': 'python3-dfvfs'
}, grain='oscodename') %}

include:
  - sift.repos.sift
  - sift.repos.gift
  {% if grains['oscodename'] == "xenial" -%}
  - sift.packages.absent.plaso
  {% endif %}

sift-package-python3-dfvfs:
  pkg.installed:
    - name: {{ package_name }}
    - version: latest
    - hold: False
    - refresh: True
    - update_holds: True
    - allow_updates: True
    - require:
      {% if grains['oscodename'] == "xenial" -%}
      - sls: sift.packages.absent.plaso
      {% endif -%}
      - sls: sift.repos.sift
      - sls: sift.repos.gift

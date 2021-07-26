# source=https://github.com/gchq/CyberChef/
# license=apache2
# license_source=https://github.com/gchq/CyberChef/blob/master/LICENSE

{% set version = "9.28.0" -%}
{% set hash = "61a58d9d678800a5b7f5a51e440e71dd0c51135c2129d42dc3ce86135c625921" -%}
include:
  - sift.packages.apache2

sift-scripts-cyberchef:
  archive.extracted:
    - name: /var/www/html/cyberchef
    - enforce_toplevel: False
    - source: https://github.com/gchq/CyberChef/releases/download/v{{ version }}/CyberChef_v{{ version }}.zip
    - source_hash: sha256={{ hash }}
    - overwrite: True
    - require:
      - sls: sift.packages.apache2

sift-scripts-cyberchef-index:
  file.rename:
    - name: /var/www/html/cyberchef/index.html
    - source: /var/www/html/cyberchef/CyberChef_v{{ version }}.html
    - force: True

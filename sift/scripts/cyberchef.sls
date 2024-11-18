# source=https://github.com/gchq/CyberChef/
# license=apache2
# license_source=https://github.com/gchq/CyberChef/blob/master/LICENSE

{% set version = "10.19.4" -%}
{% set hash = "3788b29ffb54f5784968fcf998286f0f75670be8a92e40eb683743ebaab97510" -%}
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

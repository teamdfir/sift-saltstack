# source=https://github.com/gchq/CyberChef/
# license=apache2
# license_source=https://github.com/gchq/CyberChef/blob/master/LICENSE

{% set version = "9.11.10" -%}
{% set hash = "c5e86007992015d7663eb16597900f4ed6668d1e9d70b8ac5523cd454a640061" -%}

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
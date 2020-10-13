# source=https://github.com/gchq/CyberChef/
# license=apache2
# license_source=https://github.com/gchq/CyberChef/blob/master/LICENSE
# "c5e86007992015d7663eb16597900f4ed6668d1e9d70b8ac5523cd454a640061"

{% set version = "9.21.0" -%}
{% set hash = "5a53c4e0bee1303ef73210a6e2fbb3f5151d4ad09cc3681581c6c35b15584126" -%}
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

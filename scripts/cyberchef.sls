# source=https://github.com/gchq/CyberChef/
# license=apache2
# license_source=https://github.com/gchq/CyberChef/blob/master/LICENSE

{% set version = "9.55.0" -%}
{% set hash = "DA55ADC790D011F6BF3740E7E704D340351F7E1C8EBD8E7D9DD24AA46562307C" -%}
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

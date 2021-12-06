{% if grains['oscodename'] == "xenial" -%}
include:
  - sift.repos.sift

sift-package-libpff:
  pkg.installed:
    - name: libpff
    - require:
      - sls: sift.repos.sift
{% else -%}
sift-package-libpff:
  test.nop
{% endif %}
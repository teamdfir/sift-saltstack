{% if grains['oscodename'] == "xenial" -%}
include:
  - sift.repos.sift

sift-package-libpff:
  pkg.installed:
    - name: libpff
    - require:
      - sls: sift.repos.sift
{% elif grains['oscodename'] == "bionic" -%}
sift-package-libpff:
  test.nop
{% endif %}
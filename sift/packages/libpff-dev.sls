{% if grains['oscodename'] == "xenial" -%}
include:
  - sift.repos.sift

sift-package-libpff-dev:
  pkg.installed:
    - name: libpff-dev
    - require:
      - sls: sift.repos.sift
{% elif grains['oscodename'] == "bionic" -%}
sift-package-libpff-dev:
  test.nop
{% endif %}
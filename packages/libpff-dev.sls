{% if grains['oscodename'] == "xenial" -%}
include:
  - sift.repos.sift

sift-package-libpff-dev:
  pkg.installed:
    - name: libpff-dev
    - require:
      - sls: sift.repos.sift
{% else -%}
sift-package-libpff-dev:
  test.nop
{% endif %}
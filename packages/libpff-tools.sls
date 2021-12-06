{% if grains['oscodename'] == "xenial" -%}
include:
  - sift.repos.sift

sift-package-libpff-tools:
  pkg.installed:
    - name: libpff-tools
    - require:
      - sls: sift.repos.sift
{% else -%}
sift-package-libpff-tools:
  test.nop
{% endif %}
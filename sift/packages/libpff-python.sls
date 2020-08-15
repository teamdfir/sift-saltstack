{% if grains['oscodename'] == "xenial" -%}
include:
  - sift.repos.sift

sift-package-libpff-python:
  pkg.installed:
    - name: libpff-python
    - require:
      - sls: sift.repos.sift
{% else -%}
sift-package-libpff-python:
  test.nop
{% endif %}
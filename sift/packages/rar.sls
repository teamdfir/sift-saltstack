
{% if grains["osarch"] in ["arm64", "aarch64"] %}
rar is not available on arm64 systems:
  test.nop
{% else %}

include:
  - sift.repos.ubuntu-multiverse

sift-package-rar:
  pkg.installed:
    - name: rar
    - require:
      - sls: sift.repos.ubuntu-multiverse

{% endif %}

{% if grains['oscodename'] != "noble" %}

include:
  - sift.repos.ubuntu-universe

sift-package-xmount:
  pkg.latest:
    - name: xmount
    - require:
      - sls: sift.repos.ubuntu-universe

{% else %}

{% if grains['osarch'] == "amd64" %}

sift-package-xmount:
  pkg.latest:
    - name: xmount

{% else %}

sift-package-xmount:
  test.nop:
    - name: not-supported-on-arm64

{% endif %}

{% endif %}

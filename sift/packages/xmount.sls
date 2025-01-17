{% if grains['oscodename'] != "noble" %}

include:
  - sift.repos.ubuntu-universe

sift-package-xmount:
  pkg.latest:
    - name: xmount
    - require:
      - sls: sift.repos.ubuntu-universe

{% else %}
sift-package-xmount-noble:
  pkg.latest:
    - name: xmount
{% endif %}

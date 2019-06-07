{% if grains['oscodename'] == "xenial" -%}
sift-package-apt-transport-https:
  pkg.installed:
    - name: apt-transport-https
{% else -%}
sift-package-apt-transport-https:
  test.nop:
    - name: apt-transport-https
{% endif -%}
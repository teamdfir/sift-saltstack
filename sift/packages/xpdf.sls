{%- if grains['oscodename'] == "bionic" %}
sift-package-xpdf:
  pkg.latest:
    - name: xpdf
{%- else %}
sift-package-xdf:
  test.nop
{%- endif %}



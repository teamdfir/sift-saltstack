{%- if grains['oscodename'] == "bionic" %}
sift-package-dconf-tools:
  pkg.installed:
    - name: dconf-tools
{%- else %}
sift-package-dconf-tools:
  test.nop
{%- endif %}
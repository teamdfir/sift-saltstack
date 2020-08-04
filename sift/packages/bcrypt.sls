{%- if grains['oscodename'] == "bionic" %}
sift-package-bcrypt:
  pkg.installed:
    - name: bcrypt
{%- else %}
sift-package-bcrypt:
  test.nop
{%- endif %}
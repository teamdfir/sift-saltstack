sift-package-python3:
  pkg.installed:
    - name: python3

{%- if grains["oscodename"] == "focal" %}
sift-package-python-is-python3:
  pkg.installed:
    - name: python-is-python3
{%- endif %}
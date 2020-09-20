{% set package_name = salt['grains.filter_by']({
  'xenial': 'python-xlsxwriter',
  'bionic': 'python-xlsxwriter',
  'focal': 'python3-xlsxwriter'
}, grain='oscodename') %}

{% if grains['oscodename'] != 'focal' %}
sift-python3-xlsxwriter:
  pkg.removed:
    - name: python3-xlsxwriter
{% endif %}

sift-python-xlsxwriter:
  pkg.installed:
    - name: {{ package_name }}

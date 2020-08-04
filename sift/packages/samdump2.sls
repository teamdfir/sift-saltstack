{% set package_name = salt['grains.filter_by']({
  'bionic': 'bkhive',
  'focal': 'samdump2'
}, grain='oscodename') %}

sift-package-samdump2:
  pkg.installed:
    - name: {{ package_name }}
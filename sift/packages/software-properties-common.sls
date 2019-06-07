{% set package_name = salt['grains.filter_by']({
  'xenial': 'python-software-properties',
  'bionic': 'software-properties-common',
}, grain='oscodename') %}

sift-package-software-properties-common:
  pkg.installed:
    - name: {{ package_name }}

{% set package_name = salt['grains.filter_by']({
  'xenial': 'python-yara',
  'bionic': 'python-yara',
  'focal': 'python3-yara'
}, grain='oscodename') %}


sift-package-python-yara:
  pkg.installed:
    - name: {{ package_name }}
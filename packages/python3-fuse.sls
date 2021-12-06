{% set package_name = salt['grains.filter_by']({
  'bionic': 'python-fuse',
  'focal': 'python3-fuse'
}, grain='oscodename') %}

sift-package-python3-fuse:
  pkg.installed:
    - name: {{ package_name }}
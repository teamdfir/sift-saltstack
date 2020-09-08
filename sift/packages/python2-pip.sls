{% set package_name = salt['grains.filter_by']({
  'bionic': 'python-pip',
  'focal': 'python2-pip'
}, grain='oscodename') %}

include:
  - sift.packages.python2

sift-package-python2-pip:
  pkg.installed:
    - name: {{ package_name }}
    - require:
      - sls: sift.packages.python2

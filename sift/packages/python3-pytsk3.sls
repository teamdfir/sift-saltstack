{% set package_name = salt['grains.filter_by']({
  'bionic': 'python-pytsk3',
  'focal': 'python3-pytsk3'
}, grain='oscodename') %}

include:
  - sift.repos.sift

sift-package-removed-pytsk3:
  pkg.removed:
    - name: pytsk3

sift-package-python-pytsk3:
  pkg.installed:
    - name: {{ package_name }}
    - required:
      - pkg: sift-package-removed-pytsk3
      - sls: sift.repos.sift

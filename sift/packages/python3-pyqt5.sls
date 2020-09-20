{% set package_name = salt['grains.filter_by']({
  'bionic': 'python3-pyqt4',
  'focal': 'python3-pyqt5'
}, grain='oscodename') %}

sift-package-python-pyqt:
  pkg.installed:
    - name: {{ package_name }}
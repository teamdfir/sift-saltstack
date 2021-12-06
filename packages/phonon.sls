{% set package_name = salt['grains.filter_by']({
  'bionic': 'phonon',
  'focal': 'phonon4qt5'
}, grain='oscodename') %}

sift-package-phonon:
  pkg.installed:
    - name: {{ package_name }}
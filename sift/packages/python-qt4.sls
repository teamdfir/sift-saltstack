{% set package_name = salt['grains.filter_by']({
  'xenial': 'python-qt4',
  'bionic': 'python-qt4',
  'focal': 'python-'
}, grain='oscodename') %}

python-qt4:
  pkg.installed
include:
  - sift.python-packages.ntdsxtract_{{ grains['oscodename'] }}

sift-python-ntdsxtract-distro:
  test.nop:
    - name: sift-python-ntdsxtract-distro
    - require:
      - sls: sift.python-packages.ntdsxtract_{{ grains['oscodename'] }}
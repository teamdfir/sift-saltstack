include:
  - sift.packages.readpst_{{ grains['oscodename'] }}


sift-package-readpst-distro:
  test.nop:
    - name: sift-package-readpst-distro
    - require:
      - sls: sift.packages.readpst_{{ grains['oscodename'] }}
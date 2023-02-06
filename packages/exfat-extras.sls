include:
  - sift.packages.exfat-extras_{{ grains['oscodename'] }}

sift-package-exfat-extras-distro:
  test.nop:
    - name: sift-package-exfat-extras-distro
    - require:
      - sls: sift.packages.exfat-extras_{{ grains['oscodename'] }}
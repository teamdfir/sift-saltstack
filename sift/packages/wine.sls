include:
  - sift.packages.wine_{{ grains['oscodename'] }}

sift-package-wine-distro:
  test.nop:
    - name: sift-package-wine-distro
    - require:
      - sls: sift.packages.wine_{{ grains['oscodename'] }}
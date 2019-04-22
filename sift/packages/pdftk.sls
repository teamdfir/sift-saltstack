include:
  - sift.packages.pdftk_{{ grains['oscodename'] }}

sift-package-pdftk-distro:
  test.nop:
    - name: sift-package-pdftk-distro
    - require:
      - sls: sift.packages.pdftk_{{ grains['oscodename'] }}

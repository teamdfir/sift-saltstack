include:
  - sift.packages.libafflib_{{ grains['oscodename'] }}

sift-package-libafflib-distro:
  test.nop:
    - name: sift-package-libafflib-distro
    - require:
      - sls: sift.packages.libafflib_{{ grains['oscodename'] }}

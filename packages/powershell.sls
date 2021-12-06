include:
  - sift.packages.powershell_{{ grains['oscodename'] }}

sift-package-powershell-distro:
  test.nop:
    - name: sift-package-powershell-distro
    - require:
      - sls: sift.packages.powershell_{{ grains['oscodename'] }}

include:
  - sift.scripts.afterglow_{{ grains['oscodename'] }}

sift-scripts-afterglow-distro:
  test.nop:
    - name: sift-script-afterglow
    - require:
      - sls: sift.scripts.afterglow_{{ grains['oscodename'] }}

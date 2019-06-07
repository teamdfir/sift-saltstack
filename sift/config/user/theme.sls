include:
  - sift.config.user.theme_{{ grains['oscodename'] }}

sift-config-user-theme:
  test.nop:
    - name: sift-config-user-theme
    - require:
      - sls: sift.config.user.theme_{{ grains['oscodename'] }}

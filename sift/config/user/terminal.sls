include:
  - sift.config.user.terminal_{{ grains['oscodename'] }}

sift-config-user-terminal:
  test.nop:
    - name: sift-config-user-terminal
    - require:
      - sls: sift.config.user.terminal_{{ grains['oscodename'] }}

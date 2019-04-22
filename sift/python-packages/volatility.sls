include:
  - sift.python-packages.volatility_{{ grains['oscodename'] }}

sift-python-volatility-distro:
  test.nop:
    - name: sift-python-volatility-distro
    - require:
      - sls: sift.python-packages.volatility_{{ grains['oscodename'] }}


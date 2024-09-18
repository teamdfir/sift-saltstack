include:
 - sift.apps.volatility

sift-apps:
  test.nop:
    - name: sift-apps
    - require:
        - sls: sift.apps.volatility

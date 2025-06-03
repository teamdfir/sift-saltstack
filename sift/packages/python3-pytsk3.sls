include:
  - sift.repos.gift

sift-package-python3-pytsk3:
  pkg.installed:
    - name: python3-pytsk3
    - require:
      - sls: sift.repos.gift

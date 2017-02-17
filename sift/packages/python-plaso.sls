include:
  - sift.repos.gift

python-plaso:
  pkg.installed:
    - name: python-plaso
    - require:
      - pkgrepo: gift

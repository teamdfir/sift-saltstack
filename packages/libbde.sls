include:
  - sift.repos.gift
  
libbde:
  pkg.installed:
    - name: libbde
    - require:
      - sls: sift.repos.gift

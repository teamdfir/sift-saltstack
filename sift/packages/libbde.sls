include:
  - sift.repos.gift
  
sift-package-libbde:
  pkg.installed:
    - name: libbde
    - require:
      - sls: sift.repos.gift

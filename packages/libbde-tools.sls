include:
  - sift.repos.gift

libbde-tools:
  pkg.installed:
    - name: libbde-tools
    - require:
      - sls: sift.repos.gift

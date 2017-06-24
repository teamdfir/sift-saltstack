include:
  - sift.repos.sift
  - sift.packages.wine

sift-regripper:
  pkg.installed:
    - name: regripper
    - require:
      - sls: sift.repos.sift
      - sls: sift.packages.wine

include:
  - sift.repos.gift
  - sift.repos.sift

sift-package-sleuthkit:
  pkg.latest:
    - name: sleuthkit
    - require:
      - sls: sift.repos.sift
      - sls: sift.repos.gift

include:
  - sift.repos.sift

sift-package-dumbpig:
  pkg.installed:
    - name: dumbpig
    - require:
      - sls: sift.repos.sift

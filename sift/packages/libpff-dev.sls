include:
  - sift.repos.sift

sift-package-libpff-dev:
  pkg.installed:
    - name: libpff-dev
    - require:
      - sls: sift.repos.sift

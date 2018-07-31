include:
  - sift.repos.sift

sift-package-libpff:
  pkg.installed:
    - name: libpff
    - require:
      - sls: sift.repos.sift

include:
  - sift.repos.sift

sift-package-libpff-tools:
  pkg.installed:
    - name: libpff-tools
    - require:
      - sls: sift.repos.sift

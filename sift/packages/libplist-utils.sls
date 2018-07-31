include:
  - sift.repos.sift

sift-package-libplist-utils:
  pkg.installed:
    - name: libplist-utils
    - require:
      - sls: sift.repos.sift

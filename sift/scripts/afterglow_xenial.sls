include:
  - sift.repos.sift

sift-package-afterglow:
  pkg.installed:
    - name: afterglow
    - required:
      - sls: sift.repos.sift


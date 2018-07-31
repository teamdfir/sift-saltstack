include:
  - sift.repos.sift

sift-package-python-ntdsxtract:
  pkg.installed:
    - name: python-ntdsxtract
    - require:
      - sls: sift.repos.sift

include:
  - sift.repos.sift

pytsk3-removed:
  pkg.removed:
    - name: pytsk3

pytsk3:
  pkg.installed:
    - name: python-pytsk3
    - required:
      - pkg: pytsk3-removed
      - sls: sift.repos.sift

include:
  - sift.repos.sift

sift-package-removed-pytsk3:
  pkg.removed:
    - name: pytsk3

sift-package-python-pytsk3:
  pkg.installed:
    - name: python3-pytsk3
    - required:
      - pkg: sift-package-removed-pytsk3
      - sls: sift.repos.sift

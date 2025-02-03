sift-package-removed-pytsk3:
  pkg.removed:
    - name: pytsk3

sift-package-python3-tsk:
  pkg.installed:
    - name: python3-tsk
    - require:
      - pkg: sift-package-removed-pytsk3

include:
  - sift.repos.malteworld

sift-package-pdftk:
  pkg.installed:
    - name: pdftk
    - require:
      - sls: sift.repos.malteworld
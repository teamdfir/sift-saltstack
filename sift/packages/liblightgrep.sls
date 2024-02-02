include:
  - sift.repos.sift

sift-package-liblightgrep:
  pkg.installed:
    - name: liblightgrep
    - require:
      - sls: sift.repos.sift
